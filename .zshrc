if [ -d "$HOME/.oh-my-zsh" ]; then
    ZSH_THEME="avit"
    # ZSH_THEME="minimal"
    # ZSH_THEME="refined"
    COMPLETION_WAITING_DOTS="true"
    plugins=(themes git tmux fzf debian z)

    apt_upgr='upgrade'
    apt_pref='apt-get'

    export ZSH="$HOME/.oh-my-zsh"

    zstyle ':omz:update' mode auto
    zstyle ':omz:update' verbose silent
    zstyle ':omz:update' frequency 12

    [ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

####################################################

export MANPATH="/usr/local/man:$MANPATH"
export LANG=fr_FR.UTF-8
export EDITOR=vim
export VISUAL=vim
export ARCHFLAGS="-arch x86_64"

export FZF_DEFAULT_OPTS='--layout=reverse -x'
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND='ag -l -g ""'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias l="ls -l"
alias ll="ls -l"
alias la="ls -la"
alias du="du -h"
alias df="df -h"
alias bc="bc -ql"
alias mk="make"
alias j="just"
alias jc="just --choose"
alias zz="zathura --fork"
alias lgit="git commit -a -m \"$(date)\" && git push"
alias e="vim"

export NNN_OPTS='de'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_TRASH=1
export NNN_OPENER=nopen

n() {
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
            return
    }
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
command nnn "$@"
[ ! -f "$NNN_TMPFILE" ] || {
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null }
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# vim: ft=zsh:sw=4:

