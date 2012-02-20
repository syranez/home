# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# bash configuration is version controlled by own git repository.
if [[ -f ~/.bash/bashrc ]]; then
    . ~/.bash/bashrc
fi

# CVS Settings
umask 002 
export CVSROOT=:pserver:$(id -un)@dev0.fidion.de:/CVS
alias cvs='cvs -d $CVSROOT'

[[ -f /etc/profile.d/bash-completion ]] &&
    source /etc/profile.d/bash-completion

shopt -s histappend
PROMPT_COMMAND='history -a'

# VMwares.
alias ie6="rdesktop -u fidion -p 343466 ie6.intra.fidion.de"
alias ie7="rdesktop -u fidion -p 343466 ie7.intra.fidion.de"

win7 () {
    rdesktop -u syranez -k de -g 1280x1000 192.168.42.132
}
 
PATH="/www/pfirsichtorte.naxos.fidion.de/fcmsdev/bin:${PATH}"
