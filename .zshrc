################################################################################
# Path
################################################################################

export PATH="$HOME/.cargo/bin:$PATH"                        # Rust tools
export PATH="/usr/local/sbin:$PATH"                         # Homebrew

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

# colorize and append size measures
alias ls='ls -hG'

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
switchbg() {
    if [[ "$DARKMODE" -eq 1 ]]; then
        if [[ "$LC_TERMINAL" == "iTerm2"  ]]; then
            echo -e "\033]50;SetProfile=solarized-light\a";
        else
            # if in alacritty
            sed -i '.tmp' 's/colors: \*dark/colors: \*light/' ~/code/dotfiles/alacritty.yml
            if [[ -f ~/code/dotfiles/alacritty.yml.tmp ]]; then
                rm ~/code/dotfiles/alacritty.yml.tmp
                cp ~/code/dotfiles/alacritty.yml ~/.config/alacritty/
            else
                1>&2 echo "Unable to switch alacritty settings"
            fi
        fi
        export DARKMODE=0;
        export BAT_THEME="Solarized (light)";
    elif [[ "$DARKMODE" -eq 0 ]]; then
        if [[ "$LC_TERMINAL" == "iTerm2"  ]]; then
            echo -e "\033]50;SetProfile=solarized-dark\a";
        else
            # if in alacritty
            sed -i '.tmp' 's/colors: \*light/colors: \*dark/g' ~/code/dotfiles/alacritty.yml
            if [[ -f ~/code/dotfiles/alacritty.yml.tmp ]]; then
                rm ~/code/dotfiles/alacritty.yml.tmp
                cp ~/code/dotfiles/alacritty.yml ~/.config/alacritty/
            else
                1>&2 echo "Unable to switch alacritty settings"
            fi
        fi
        export DARKMODE=1;
        export BAT_THEME="Solarized (dark)";
    else
        1>&2 echo "Unexpected DARKMODE value: $DARKMODE"
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
    }
else
    function refresh { }
fi

################################################################################
# Specific tools
################################################################################

# fzf
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'bat --style=numbers --color=always {} | head -500'"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# Biostar Handbook things
export LC_ALL=C
export PERL_LWP_SSL_VERIFY_HOSTNAME=0
export PATH=~/bin:$PATH
