# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Machine-specific configurations
[ -f ~/.bash_machine ] && . ~/.bash_machine

# Alias definitions.
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

#handy functions
[ -f ~/.bash_functions ] && . ~/.bash_functions

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

if [[ "$TERM" != *256color && "$TERM" != linux ]]; then
	if [ "`tput -Txterm-256color colors 2>/dev/null`" == "256" -a $? -eq 0 ]; then
		export TERM=xterm-256color
	elif [ "`tput -Trxvt-256color colors 2>/dev/null`" == "256" -a $? -eq 0 ]; then
		export TERM=rxvt-256color
	fi
fi


#build better detection for 256 versus regular here.
# also, add window title dressing?
# This is useful for if in a chroot
if [[ "$HOSTTYPE" == i?86 ]]; then
	DIR_COLOR='\[\e[0;1;33m\]'
else
	DIR_COLOR='\[\e[0;32m\]'
fi
AT_COLOR='\[\e[0;30m\]'

if [ -n "$OVERRIDE_HOSTNAME_COLOR" ]; then
	HOSTNAME_COLOR=$OVERRIDE_HOSTNAME_COLOR
else
	HOSTNAME_COLOR='\[\e[0;1;35m\]'
fi

GIT_BRANCH_COLOR='\[\e[0;1;33m\]'

# root users are RED
if [ $UID == '0' ]; then
	USER_COLOR='\[\e[0;31m\]' 
	FINAL_SEP='#' 
else
	USER_COLOR='\[\e[0;1;30m\]'
	FINAL_SEP='$'
fi

if [ -n "$COLORTERM" ]; then
	# Using the following is slightly lighter on the system 
	# compared to the PROMPT_COMMAND 
	function xtitle() { 
		echo -ne "\033]0;$*\007" 
	}

	function cd() { 
		builtin cd "$@" && xtitle ${HOSTNAME}: ${PWD/$HOME/~} 
	}
	xtitle ${HOSTNAME}: ${PWD/$HOME/~}
fi

[ $TERM == 'linux' ] && STR_MAX_LENGTH=2 || STR_MAX_LENGTH=3

NEW_PWD='$(
p="${PWD/$HOME/}";
[ "$p" != "$PWD" ] && echo -n "~";
until [ "$p" == "$d" ]; do
	echo -n "${d:0:'"$STR_MAX_LENGTH"'}/";
	p=${p#*/};
	d=${p%%/*};
done;
[ "$d" ] && echo -n "${d}/";
)'


PS1_ERROR='$(
ret=$?;
if [ $ret -gt 0 ]; then
	(( i = 3 - ${#ret} ));
	echo -n "\[\e[0;1;31m\][";
	[ $i -gt 0 ] && echo -n " ";
	echo -n "$ret";
	[ $i -eq 2 ] && echo -n " ";
	echo -n "] \[\e[0m\]";
fi
)'

source /usr/lib/git-core/git-sh-prompt
PS1="$PS1_ERROR$USER_COLOR\u$AT_COLOR@$HOSTNAME_COLOR\h:$DIR_COLOR$NEW_PWD$GIT_BRANCH_COLOR\$(__git_ps1 && echo ' ')$USER_COLOR$FINAL_SEP \[\e[0m\]"

unset PS1_ERROR USER_COLOR AT_COLOR HOSTNAME_COLOR DIR_COLOR NEW_PWD FINAL_SEP STR_MAX_LENGTH


# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	if [ -f ~/.dir_colors ] && which dircolors >/dev/null; then
		eval `dircolors -b ~/.dir_colors`
	fi

fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
	# this will add apt-get tab completion to my hacked shorthand function
	if [ -x ~/bin/ag ]; then
		complete -F _apt_get ag
	fi
fi


# use vim for editing
export EDITOR="vim"
export VISUAL="vim"

# use less for paging through text
export PAGER="less"

# options to less
#   -i  ignore case while searching
#   -M  always show line numbers and percentage
#   -R  pass-through ANSI color escapes
#   -S  do not wrap lines
#   -W  highlight first new line after movement
export LESS="-iMRSW"

# colorize grep
# --color=auto = don't colorize when being piped (i.e. |less )
# -n = show line number it was found on
# -I = ignore binary files
# also ignore .svn folder and ctags files
#export GREP_OPTIONS="--color=auto -I --exclude-dir='.svn' --exclude=tags"

# history -a appends this window's commands to HISTFILE
# history -n reloads the fucking history every time!
# this all seems dumb to be here so I'm putting it in .bash_logout
# and seeing what happens
#PROMPT_COMMAND='history -a;history -n'
#PROMPT_COMMAND='history -a'

HISTCONTROL=ignoreboth
# already forgot what all these symbols mean
export HISTIGNORE="&:[ ]*:exit"
HISTSIZE=10000
HISTFILESIZE=10000

# append to the history file
shopt -s histappend

# re-edit failed history substitutions
shopt -s histreedit

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# ignore case while expanding filenames
shopt -u nocaseglob

# make multiline commands all be one when searching history
shopt -s cmdhist

# multiline has embedded newline instead of ;
shopt -u lithist

# correct spelling errors when using cd
shopt -s cdspell

# include filenames starting with . with filename expansion
shopt -u dotglob

# echo expands backslash-escape sequences
shopt -u xpg_echo

#setterm -background black -foreground white -ulcolor bright blue -store
source ~/.git-completion.bash
