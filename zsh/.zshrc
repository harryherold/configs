export TERM="xterm-256color"
export DOCKER_ID_USER="harryherold"
export ZSH=/home/cherold/.oh-my-zsh
export DISABLE_AUTO_TITLE='true'

source /usr/share/zsh/share/antigen.zsh

ZSH_THEME="seeker"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_DISABLE_RPROMPT="true"
POWERLINE_NO_BLANK_LINE="true"

plugins=(git svn-fast-info virtualenv)

export EDITOR="vim"
export MODULEPATH="/home/cherold/procs/modulefiles:/home/cherold/.local/easybuild/modules/all:$MODULEPATH"
export EASYBUILD_PREFIX=$HOME/.local/easybuild
export EASYBUILD_CONFIGFILES=/home/cherold/.config/easybuild/config.cfg

# export PAGER=most


function mkch()
{
    mkdir $1 && cd $_
}

function mfl()
{
    module load $(cat env.mods)
}

function pcd()
{
    cd $PROJECT_ROOT
}

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
fi

if [ -d $HOME/.local/bin ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

source $ZSH/oh-my-zsh.sh
source /etc/profile.d/autojump.sh

export PATH="/home/cherold/bin:$PATH"
alias vpn="sudo openconnect --script /etc/vpnc/vpnc-script vpn2.zih.tu-dresden.de"
alias screenshot="deepin-screenshot"
alias ll="ls -l"
alias l="ls"
alias git-info="git config --get remote.origin.url"
alias gls="/home/cherold/bin/git_ls.sh"
#alias vim="nvim"
alias tp="/home/cherold/bin/tp_fzf.sh"
alias sysinfo="inxi -Fxxxz"
alias em="emacs -nw"
alias m="micro -tabstospaces true"

eval "$(pipenv --completion)"
eval "$(pyenv init -)"

setopt append_history       # append to history, dont truncate it
setopt no_csh_junkiehistory # csh sucks
#setopt no_extended_history  # regular history
##setopt hist_allow_clobber   # add | to redirections in history
#setopt no_hist_beep         # don't beep on history expansion errors
#setopt hist_no_functions    # don't save functions defs in history
#setopt hist_save_no_dups    # no dups on history saving
#setopt no_inc_appendhistory # dont' append incrementally
#setopt no_prompt_bang       # dont perform history expansion in prompt
setopt no_share_history     # traditional bash-history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
