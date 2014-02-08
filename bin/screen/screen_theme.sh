#!/bin/bash

INDEXFILE="$HOME/bin/screen/themes/theme_index"

# if this is the first time then set
# the index to 0

if [[ ! -e $INDEXFILE ]]
then
  echo 0 > $INDEXFILE
fi

THEMENO=`cat $INDEXFILE`

THEMEMAX=5

if [[ $THEMENO -eq $THEMEMAX ]]
then
  THEMENO=0
else
  THEMENO=`expr $THEMENO + 1`
fi

echo $THEMENO > $INDEXFILE

THEMEFILE=$HOME/bin/screen/themes/theme${THEMENO}

if [[ -e $THEMEFILE ]]
then
  bash $THEMEFILE $STY
else

  # reset the index back to zero if broken

  echo 0 > $INDEXFILE
fi
