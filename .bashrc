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

# bash configuration for fidion systems.
if [[ -f ~/.bashrc.fidion ]]; then
    . ~/.bashrc.fidion
fi

# bash configuration for naxos.
if [[ -f ~/.bashrc.fidion.naxos ]]; then
    . ~/.bashrc.fidion.naxos
fi
