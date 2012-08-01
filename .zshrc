# Prompt
PS1=$(print '\n[%D %T] %{%F{green}%n%{%F{default} in %U%{%F{blue}%d%{%F{default}%u\n%E=> ')

#
# User Aliases

## functional
### ls colors and junk
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
# The order for the color definitions is: DIR, SYM_LINK, SOCKET, PIPE, EXE
#                                         BLOCK_SP, CHAR_SP, EXE_SUID, EXE_GUID
#                                         DIR_STICKY, DIR_WO_STICKY
# And the colors are: 'a' - black, 'b' = red, 'c' = green, 'd' = brown, 
#                     'e' - blue, 'f' = magenta, 'g'=cyan, 'h' = light gray
#                     'x' - default  * upper case versions will bold
# The colors are defined in pairs, foreground background
# ie. foreground=blue background=magenta: ef
# My colors:
#   DIR       BLUE on default
#   SYM_LINK  cyan on default
#   SOCKET    magenta on default
#   PIPE      green on black
#   EXE       MAGENTA on black
#   BLOCK_SP  brown on default
#   CHAR_SP   brown on default
#   EXE_SUID  gray on red
#   EXE_GUID  black on brown
#   DIR_STICKY  red on default
#   DIR_WO_STICKY  red on default
export LSCOLORS='Exgxfxcxdxdxhbadbxbx'
alias ls='ls -alh'

### other
alias g='git'
alias netstat='netstat -ant'
alias rm='rm -i'


## l33t
alias dir='echo This isnt windows man...'

# Some zsh Settings

## History Options
HISTFILE=~/.zsh_history_`date +%Y-%m-%d`       # store history in files by date
HISTSIZE=500                  # keep a max of 500 items in the internal history
SAVEHIST=10000                # keep up to 10k items in our daily history file
setopt   appendhistory        # multiple zsh's all append to the same history 
                              # file (rather than the last one overwrites)
setopt   extendedhistory      # Save each command's beginning timestamp and the
                              # duration (in seconds) to the history file
setopt incappendhistory       # append each line as it is called, and not at the
                              # time the shell closes
setopt histreduceblanks       # don't save blanks
