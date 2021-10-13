# Path to your oh-my-zsh installation.
export ZSH=/Users/zankard/.oh-my-zsh
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

KEYTIMEOUT=1

. `brew --prefix`/etc/profile.d/z.sh

ZSH_THEME_TERM_TITLE_IDLE="%~"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# if ! [[ $VSCODE_PID == "" ]]; then
#   ZSH_THEME="af-magic"
# else
#   ZSH_THEME="noob"
# fi

#ZSH_THEME="noob"
#ZSH_THEME="powerlevel10k/powerlevel10k"

# configure fzf
# export FZF_TMUX_OPTS=

if ! [[ $TMUX == "" ]]; then
  export FZF_TMUX=1
fi
FORGIT_FZF_DEFAULT_OPTS="
--exact
--reverse
"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z docker zsh-syntax-highlighting helm fzf fzfutils forgit gh yarn npm golang zsh-autosuggestions)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/go/bin:/usr/local/flutter/bin:/Users/zankard/go/bin:/Users/zankard/.cargo/bin:/Users/zankard/.local/bin:/usr/local/opt/llvm/bin"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
path_prepend() {
  if [ -d "$1"  ]; then
    PATH=${PATH//":$1:"/:} #delete all instances in the middle
    PATH=${PATH/%":$1"/} #delete any instance at the end
    PATH=${PATH/#"$1:"/} #delete any instance at the beginning
    PATH="$1${PATH:+":$PATH"}" #prepend $1 or if $PATH is empty set to $1
  fi
}
# This is needed so HomeBrew packages get priority
path_prepend '/usr/local/bin'


# if command -v pyenv &>/dev/null; then
  # eval "$(pyenv init -)"
# fi
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init -)"
fi

alias crunchifyShowFiles='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias crunchifyHideFiles='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
# export ANDROID_HOME=/usr/local/opt/android-sdk

# tmuxinator completion
#source ~/.bin/tmuxinator.zsh

# proxy configuration
plocal() {
  export http_proxy=http://localhost:8888
  export https_proxy=http://localhost:8888
}
nonp() {
  unset http_proxy
  unset https_proxy
}
#export NO_PROXY="127.0.0.1, localhost, 192.168.1.10, 172.16.212.132, 172.16.212.133, 172.16.212.134, 172.16.212.135, 172.16.212.136, 172.16.212.137,192.168.64.4"
export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24,192.168.64.0/24

alias fcl="fortune | cowsay | lolcat"


#alias nunit3="mono /usr/local/opt/nunit/bin/nunit3-console.exe"
#alias nuget="mono /usr/local/bin/nuget.exe"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/zankard/.sdkman"
[[ -s "/Users/zankard/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/zankard/.sdkman/bin/sdkman-init.sh"
alias ld='lazydocker'
alias k=kubectl
alias kc1='kubectl --context cluster1'
alias km='kubectl --context minikube'
alias diff='diff --color=auto'
alias e='exa'
alias n='nvim'
alias lg='lazygit'

# minio config
export MC_HOST_CLUSTER1=http://minio:minio123@minio.cluster1.k8s.local

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# Installation:
#
# Via shell config file  ~/.bashrc  (or ~/.zshrc)
#
#   Append the contents to config file
#   'source' the file in the config file
#
# You may also have a directory on your system that is configured
#    for completion files, such as:
#
#    /usr/local/etc/bash_completion.d/

###-begin-flutter-completion-###

if type complete &>/dev/null; then
  __flutter_completion() {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           flutter completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F __flutter_completion flutter
elif type compdef &>/dev/null; then
  __flutter_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 flutter completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef __flutter_completion flutter
elif type compctl &>/dev/null; then
  __flutter_completion() {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       flutter completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K __flutter_completion flutter
fi

###-end-flutter-completion-###

## Generated 2019-09-21 03:54:15.702269Z
## By /usr/local/flutter/bin/cache/flutter_tools.snapshot

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

SERVERLESS_PLATFORM_VENDOR=aws

# tabtab source for packages
# uninstall by removing these lines
# [[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

eval "$(starship init zsh)"
