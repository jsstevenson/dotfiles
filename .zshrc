### PATH stuff

# Rust tools
export PATH="$HOME/.cargo/bin:$PATH"

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# Miniconda
export PATH="$PATH:$HOME/opt/miniconda3/bin"


### Prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

setopt PROMPT_SUBST
PROMPT='%9c%{%F{blue}%}$(parse_git_branch)%{%F{none}%} %% '

export PS2="> "

#### Git
# branch autocomplete TODO

### Defaults/aliases
# Set default editor to NeoVIM
export EDITOR=/usr/local/bin/nvim
export VISUAL=/usr/local/bin/nvim

# open current director in Finder
alias f='open -a Finder ./'

# homebrew catch-all alias
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# combined cd and ls
function cd {
    builtin cd "$@" && ls
}

# fix weird public wifi hotspot stuff

alias clean_net_config='sudo rm /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist;
sudo rm /Library/Preferences/SystemConfiguration/com.apple.network.identification.plist;
sudo rm /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist;
sudo rm /Library/Preferences/SystemConfiguration/preferences.plist;
echo "now restarting....";
sudo shutdown -r now'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jamesstevenson/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jamesstevenson/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jamesstevenson/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jamesstevenson/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda deactivate
# <<< conda initialize <<<

