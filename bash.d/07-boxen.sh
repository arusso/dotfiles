# only load boxen if it looks like it's installed and hasn't been loaded already
if [ -f '/opt/boxen/env.sh' ] && [ -z "$BOXEN_HOME" ]; then
  . /opt/boxen/env.sh
fi
