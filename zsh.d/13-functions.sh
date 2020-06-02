# normalize a mac address to form EUI64 form.
nmac ()
{
  [[ "$PLATFORM" -eq "OSX" ]] && SED=$(which gsed 2>/dev/null) || SED=$(which sed 2>/dev/null)
  echo $1 | $SED -e 's/[.:]//g;s/.\{2\}/&:/g;s/:$//;s/./\U&/g'
}
