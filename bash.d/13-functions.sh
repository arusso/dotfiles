# Function: toggle_set
# Usage: toggle_set <0|1> "<value if 1>" "<value if 0>"
# Description:
#
#   A simple function to return one of two values based on the value of the
#   first toggle parameter. If the toggle parameter is not 0 (true) the first
#   value is returned. Otherwise, the 2nd value is returned.
#
toggle_set() {
  local TOGGLE=$1
  local VALUE1=$2
  local VALUE0=$3

  if [[ $TOGGLE -eq 0 ]]; then
    echo $VALUE0
  else
    echo $VALUE1
  fi
}

# Function: runon
# Usage: runon <hostname> "<command>"
#
#   A wrapper around ssh to run commands on remote hosts quickly. By default, no
#   TTY is allocated. You can set RUNON_FORCE_TTY=1 to force allocation of one.
#
runon() {
  RUNON_FORCE_TTY=${RUNON_FORCE_TTY:-0}
  local RUNON_TTY=$(toggle_set $RUNON_FORCE_TTY "-t" "-T")

  CLIENT=$1
  COMMAND=$2
  if [[ "$1" == "" || "$2" == "" ]]; then
    echo "USAGE: $0 <client> \"<command>\"    "
  else
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -a  ${RUNON_TTY} ${CLIENT} "$2"
  fi
}

# Function: remote_diff
# Usage: remote_diff <filename> <host a> <host b>
#
#   Compare the same file on two different hosts.
#
remote_diff() {
  if [[ "$1" == "" || "$2" == "" ]]; then
    echo "usage: $0 FILENAME HOST_A HOST_B"
    echo
    echo "Compare the same file on two different hosts"
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
    if [[ -z "$SED" ]]; then
      echo "couldn't find gsed! try 'homebrew install gnu-sed'"
      return
    fi
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
  if [[ $PLATFORM == "OSX" ]]; then
    date -r $epoch
  else
    # assume LINUX otherwise
    date -d @$epoch
  fi
}

# normalize a mac address to form EUI64 form.
nmac ()
{
  [[ "$PLATFORM" -eq "OSX" ]] && SED=$(which gsed 2>/dev/null) || SED=$(which sed 2>/dev/null)
  echo $1 | $SED -e 's/[.:]//g;s/.\{2\}/&:/g;s/:$//;s/./\U&/g'
}

# print a histogram of file size distribution
#
# based on: https://superuser.com/a/1100340
#
# example: ls -l | fshisto
fshisto() {
  awk '
  function cmp_num_idx(i1, v1, i2, v2)
  {
    # numerical index comparison, ascending order
    return (i1 - i2)
  }
  {
    n=int(log($5)/log(2));
    if (n<10) n=10;
    size[n]++;
    contribution[n]+=$5;
    total+=$5;
  } END {
    PROCINFO["sorted_in"] = "cmp_num_idx"
    for (i in size) {
      printf(                  \
        "%d %d %d %f %f\n",    \
        2^i,                   \
        size[i],               \
        contribution[i],       \
        contribution[i]/total, \
        1-cumulative_contribution/total);
        cumulative_contribution+=contribution[i];
    }
  }' \
  | sort -n                                                               \
  | awk '
    function human(x) {
      x[1]/=1024;                                  \
      if (x[1]>=1024) { x[2]++; human(x) }
    } BEGIN {
      printf("%4s: %6s %6s %7s %7s\n", "size", "count", "total", "percent", "subpcnt")
    }
    {
      a[1]=$1
      a[2]=0
      human(a);
      b[1]=$3;
      b[2]=0;
      human(b);
      $4;
      printf(                                 \
        "%3d%s: %6d %5d%s %6.2f%% %6.2f%%\n", \
        a[1],                                 \
        substr("kMGTEPYZ",a[2]+1,1),          \
        $2,                                   \
        b[1],                                 \
        substr("kMGTEPYZ",b[2]+1,1),          \
        $4*100,                               \
        $5*100)
    }'
}
