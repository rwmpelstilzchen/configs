emulate -L zsh

# Create a directory and change to it
mcd() { mkdir -p "$@" && cd "$@" }

dcp() {
    if [[ -d $2 ]] {
        mkdir -p $2 && cp $1 $2
    } else {
        mkdir -p dirname $2 && cp $1 $2
    }
}

# Change to directory and list the content
lcd() {
    cd "$@" && ls
}

# Simple slmenu based function to change directories
ch() {
  dirs=$(find -L -maxdepth 1 -type d -name '*' ! -name '.*' -printf '%f\n')
  cd $(echo $dirs | slmenu -p λ)
}

# Handle the start/stop/restart and reload of daemons uniformly.
# It's able to handle multiple daemons.
start restart stop reload(){
  local daemonPath distro cmd
  if [[ $# -le 0 ]]; then
    echo "Usage: start [restart, stop, reload] DAEMON [DAEMON ...]"
    return 1
  fi
  distro=$(cat /etc/issue)
  case $distro in
          *"Arch Linux"*)
                daemonPath="/etc/rc.d/" ;;
          *"Debian GNU/Linux"*)
                daemonPath="/etc/init.d/" ;;
          *)
                echo "Distro not supported"
                exit 1
  esac
  if [[ $UID = 0 ]]; then
      foreach daemon ($*); do
        $daemonPath$daemon $0
      done
  else
      foreach daemon ($*); do
         cmd="$cmd $daemonPath$daemon $0;"
      done
      su --command="$cmd"
  fi
  unset daemonPath distro
}

# Very simple hexeditor that uses the editor
# specified in $EDITOR. Needs the package moreutils:
# http://joey.kitenet.net/code/moreutils/
hexeditor(){
    local input output
    if [[ ! -f $1 ]] {
        touch $1
    }
    input=$1
    output=$2
    if [[ $# -eq 1 ]] {
        output=$1
    }
    xxd $input | vipe | xxd -r | sponge $output
    unset input output
}

# Peristent directory stack by
# Christian Neukirchen <http://chneukirchen.org/blog/archive/2012/02/10-new-zsh-tricks-you-may-not-know.html>
DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}
