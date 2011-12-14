# /etc/skel/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

# source keys
keychain ~/.ssh/id_dsa
. ~/.keychain/$HOSTNAME-sh

keychain ~/.ssh/arbeit
. ~/.keychain/$HOSTNAME-sh
