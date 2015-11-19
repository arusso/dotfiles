if [[ "$PLATFORM"  == "OSX" ]]; then
  BASE64_BREAK="--break=0"
elif [[ "$PLATFORM" == "Linux" ]]; then
  BASE64_BREAK="-w 0"
else
  BASE64_BREAK=
fi

newpass() {
  OSSL=$(which openssl)
  if [ -x $OSSL ]; then PASS=$($OSSL rand -base64 32); PASS=${PASS:0:24};
  else
    PASS=$(read -s salt; echo $salt $(date +%s) | shasum -a 512 | base64 ${BASE64_BREAK} | cut -c -24)
  fi
  echo $PASS
}

hourglass(){ trap 'tput cnorm' EXIT INT;local s=$(($SECONDS +$1));(tput civis;while [[ $SECONDS -lt $s ]];do for f in '|' '\' '-' '/';do echo -n "$f" && sleep .2s && echo -n $'\b';done;done;);tput cnorm;}

runon() { CLIENT=$1; COMMAND=$2; if [[ "$1" == "" || "$2" == "" ]]; then echo "USAGE: $0 <client> \"<command>\"    "; else ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -a -T ${CLIENT} "$2"; fi }

# cool snippet a friend showed me. takes a diff of a file on two different
# hosts, from this host.
assdiff() {
  if [[ "$1" == "" || "$2" == "" ]]; then
    echo "usage: assdiff <filename> <host a> <host b>"
    echo ""
    echo "Example:"
    echo "  Take a diff of /etc/hosts on hostA and hostB:"
    echo "  $ assdiff /etc/hosts hostA hostB"
  else
    diff -u <(ssh $2 "sudo cat $1") <(ssh $3 "sudo cat $1")
  fi
}

function replace_text() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage:"
    echo "  replace_text 's/OLDREGEX/NEWTEXT/g' FILEGLOB"
  else
    echo perl -pi -e $1 $2
  fi
}

function check_erb() {
  erb -P -x -T '-' $1 | ruby -c
}


# iterates through a file of hostnames, one per line, and tests them against a
# specified environment name
#
# usage: test_puppet_branch <hosts file> <environment name>
function test_puppet_branch() {
  _filename="$1"
  _environment="$2"
  _usage="usage: FILENAME ENVIRONMENT

    FILENAME - name of file containing hosts to test
    ENVIRONMENT - puppet environment to test"

  # verify our filename
  if ! /bin/test -f "$_filename"; then
    echo "invalid file specified, '${_filename}'" 1>&2
    echo 1>&2
    echo "$_usage" 1>&2
    return 1
  fi

  # make sure we passed something for the environment
  if /bin/test -z "${_environment}"; then
    echo "you must specify an environment!" 1>&2
    echo 1>&2
    echo "$_usage" 1>&2
    return 1
  fi

  # stay in the loop
  echo "beginning testing of environment '${_environment}'"
  echo "reading from file '${_filename}'"
  echo "press CTRL-C to stop..."
  while [ 1 -eq 1 ]; do
    # read each line
    while read line; do
      for hst in $(eval "echo $line"); do 
        echo "#### HOST: ${hst} ####"
        runon ${hst} "sudo puppet agent -t --noop --environment ${_environment}"
        echo "#######################"
      done
      # delete the entry from our file
      eval "sed -i '' -e '/^$line\$/d'" $_filename
    done < $_filename
    # sleep afterwards to prevent spinning our wheels
    sleep 1
  done
}

get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# alternative for fold command that also allows me to add a prepending character
# each line that is folded
fold2() {
  TEST=$(which test)
  if $TEST "$PLATFORM" = "OSX"; then
    SED=$(which gsed)
  else
    SED=$(which sed)
  fi
  local input="$1"
  local len=${2-80}
  local prefix=${3-}

  echo "$input" | $SED -n ':p;s/\([^\n]\{'"${len}"'\}\)\([^\n]\)/\1\n'"${prefix}"'\2/;tp;p'
}

epoch2date() {
  epoch=$(echo "$1"|sed 's/\..*$//')
  date -r $epoch
}
