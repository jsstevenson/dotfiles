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

# force utf-8 in tmux
alias tmux='tmux -u'

# homebrew catch-all alias
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# combined cd and show directory (exa)
function cd {
    builtin cd "$@" && exa
}

# colorize and append size measures
alias ll='exa -l'

# default tree args
alias trc='tree -AC'

# open journal
alias journal='nvim /Users/jss/code/journal.md'

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

if [[ "$TERM_PROGRAM" = "iTerm.app" || "$TERM_PROGRAM" = "alacritty" ]]; then
    # default value
    if [ -z ${DARKMODE+x} ]; then
        export BAT_THEME="Solarized (dark)"
        export DARKMODE=1;
        gsed -i 's/colors: \*light/colors: \*dark/' /Users/jss/code/dotfiles/alacritty.yml
    fi

    # swap light/dark colors
    switchbg() {
        if [[ "$DARKMODE" -eq 1 ]]; then
            if [[ "$LC_TERMINAL" == "iTerm2"  ]]; then
                echo -e "\033]50;SetProfile=solarized-light\a";
            elif [[ "$TERM_PROGRAM" == "alacritty" ]]; then
                gsed -i 's/colors: \*dark/colors: \*light/' /Users/jss/code/dotfiles/alacritty.yml
            fi
            export DARKMODE=0;
            export BAT_THEME="Solarized (light)";
        elif [[ "$DARKMODE" -eq 0 ]]; then
            if [[ "$LC_TERMINAL" == "iTerm2"  ]]; then
                echo -e "\033]50;SetProfile=solarized-dark\a";
            elif [[ "$TERM_PROGRAM" == "alacritty" ]]; then
                gsed -i 's/colors: \*light/colors: \*dark/' /Users/jss/code/dotfiles/alacritty.yml
            fi
            export DARKMODE=1;
            export BAT_THEME="Solarized (dark)";
        else
            1>&2 echo "Unexpected DARKMODE value: $DARKMODE"
        fi;
    }

    # tmux hook should render this unnecessary, but just in case:
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
elif [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
    export BAT_THEME="GitHub"
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

