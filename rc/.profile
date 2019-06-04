# source .bashrc if the shell is bash
[ -d ~/bin ] && PATH="${PATH}":~/bin
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

