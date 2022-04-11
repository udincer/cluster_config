# .bashrc

umask 0022
alias jn='jupyter lab --port 8897 --ServerApp.token=token123'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ll='ls -lah'
alias l='exa -lhF'
export EXA_COLORS="ur=37:uw=37:ux=37:ue=37:gr=37:gw=37:gx=37:ge=37:tr=37:tw=37:tx=37:te=37"

alias gs='git status'
alias gp='git push'

# max-columns: avoid printing binary blobs with the max-columns flag in ripgrep
alias rg="rg --max-columns 150"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# add qstat, qsub, etc.
export PATH="$PATH:/u/systems/UGE8.6.4/bin/lx-amd64"