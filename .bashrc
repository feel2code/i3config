#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cat='bat'
alias top='htop'
alias steam='steam -forcedesktopscaling 2'
PS1='[\u@\h \W]\$ '

GTK_THEME=Adwaita:dark
GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
QT_STYLE_OVERRIDE=adwaita-dark
[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt
