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

check_erb() {
  erb -P -x -T '-' $1 | ruby -c
}
