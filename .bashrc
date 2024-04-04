#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -lah --color=auto'
alias grep='rg --color=auto'
alias vim='nvim'
alias top='htop'
alias hostname='cat /etc/hostname'
alias steam='steam -forcedesktopscaling 2'
PS1='[\u@\h \W]\$ '

GTK_THEME=Adwaita:dark
GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
QT_STYLE_OVERRIDE=adwaita-dark
[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source /usr/share/git/completion/git-completion.bash
