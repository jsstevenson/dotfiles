################################################################################
# Path
################################################################################

export PATH="$HOME/.cargo/bin:$PATH"                        # Rust tools
export PATH="/usr/local/sbin:$PATH"                         # Homebrew
export PATH="$HOME/miniconda3/bin/:$PATH"                   # Miniconda

################################################################################
# Prompt
################################################################################

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

setopt PROMPT_SUBST
PROMPT='%9c%{%F{blue}%}$(parse_git_branch)%{%F{none}%} %% '

export PS2="> "

################################################################################
# Git
################################################################################

# branch autocomplete TODO

################################################################################
# Defaults/aliases
################################################################################

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

################################################################################
# Appearance
################################################################################

# default value
if [ -z ${DARKMODE+x} ]; then
    export DARKMODE=1;
fi

# swap light/dark colors
switchprof() {
    if [[ "$DARKMODE" -eq 1 ]]; then
        export DARKMODE=0;
        echo -e "\033]50;SetProfile=solarized-light\a";
    else
        export DARKMODE=1;
        echo -e "\033]50;SetProfile=solarized-dark\a";
    fi;
}

if [ -n "$TMUX" ]; then
  function refresh {
    export $(tmux show-environment | grep "^DARKMODE")
  }
else
  function refresh { }
fi

################################################################################
# Specific tools
################################################################################

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
