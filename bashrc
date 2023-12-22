#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Ranger shell prompt indicator
if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi

export PATH=/home/crw/bin:/usr/local/bin:/home/crw/.local/bin:/opt/cuda/bin:/home/crw/.mambaforge/condabin:/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/cuda/bin:/opt/cuda/nsight_compute:/opt/cuda/nsight_systems/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/cuda/bin:/opt/cuda/nsight_compute:/opt/cuda/nsight_systems/bin
export DDRIVER_TYPE='u'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/crw/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/crw/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/crw/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/crw/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/crw/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/crw/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

