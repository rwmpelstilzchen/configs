# Extending PATH
PATH=$PATH:$HOME/.cabal/bin:$HOME/.bin
export PATH

# Starting X when login in on tty1
if [ "$(tty)" = "/dev/tty1" ]; then
    # Check for backup before login
    # and start ssh-agent with X
    backup && ssh-agent startx &!
fi