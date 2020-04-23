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
    export BAT_THEME="Solarized (dark)"
    export DARKMODE=1;
fi

# swap light/dark colors
switchprof() {
    if [[ "$DARKMODE" -eq 1 ]]; then
        echo -e "\033]50;SetProfile=solarized-light\a";
        export DARKMODE=0;
        export BAT_THEME="Solarized (light)";
    else
        echo -e "\033]50;SetProfile=solarized-dark\a";
        export DARKMODE=1;
        export BAT_THEME="Solarized (dark)";
    fi;
}

if [ -n "$TMUX" ]; then
    function refresh {
        darkmode_setting=$(tmux show-environment | grep "^DARKMODE");
        battheme_setting=$(tmux show-environment | grep "^BAT_THEME");
        if [[ -n "$darkmode_setting" ]]; then
            export "$darkmode_setting"
        else
            echo "Tmux couldn't get darkmode setting";
        fi

        if [[ -n "$battheme_setting" ]]; then
            export "$battheme_setting";
        else
            echo "Tmux couldn't get bat theme setting";
        fi

        # export $(tmux show-environment | grep "^DARKMODE");
        # export $(tmux show-environment | grep "^BAT_THEME");
    }
else
    function refresh { }
fi

################################################################################
# Specific tools
################################################################################

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
