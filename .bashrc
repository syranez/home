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

[[ -f /etc/profile.d/bash-completion ]] &&
    source /etc/profile.d/bash-completion

shopt -s histappend
PROMPT_COMMAND='history -a'
