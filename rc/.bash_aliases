# Alias definitions.

# unalias everything first
unalias -a

alias pu="pushd"
alias po="popd"
alias ll='ls -lhF'
alias la='ls -AFG'
alias lal='ls -AlFh'
alias l='ls -CF'
alias lt='ls -AFlhtr'
alias today='date +%Y-%m-%d'
alias ..='cd ..'
alias sdr="screen -A -d -r"
alias sxr="screen -A -x -r"

alias psed="perl -p -i -e"
alias catc="pygmentize -g"

# The LESS env var isn't working.
# actually it is.
#alias less="less -iMRS"
if [ ! -x /bin/more ]; then
	alias more="less"
fi

# The LS_OPTIONS env var doesn't work
alias ls="ls -F --color=auto"
alias less="less -iMRSW"

#Add OS detection code here
case "$OSTYPE" in
	cygwin)
		alias start="cmd /c start"
		alias open="cmd /c start"
		alias kill="kill -f -9"
		alias pse="ps -e"
		alias psa="ps -aW"
		#cygwin and their termcap sucks...
		if which clear >/dev/null 2>&1
		then
			alias clear="TERM=xterm `which clear`"
		fi
		alias man="TERM=xterm `which man`"
		alias update-rc="ssh jwiens@h.ia.io /var/www/rc/rcfiles.sh|tar -wzxvC ~/"
		;;
	linux*)
		alias start="gnome-open"
		alias open="gnome-open"
		alias pse="ps -e"
		alias psa="ps aux"
		;;
	darwin*)
		alias start="open"
		alias pse="ps -e"
		alias psa="ps aux"
		alias ls="ls -G -F"
		#Install from macports...
		alias seq="gseq"

		;;
esac
