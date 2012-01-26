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

# overwrite settings with host settings
if [[ -f ~/.home/bashrc ]]; then
    . ~/.home/bashrc
fi
