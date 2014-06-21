# Predictable SSH authentication socket location. Useful when
# we use tmux/screen and detach/attach sessions
SOCK="$HOME/.ssh/ssh_auth_sock"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f $SOCK
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi
