################################################################################
# Path
################################################################################

export PATH="$HOME/.local/bin:$PATH"                        # local binaries
export PATH="/Applications/Julia-1.6.app/Contents/Resources/julia/bin:$PATH"    # Julia
export PATH="$HOME/.cargo/bin:$PATH"                        # Rust tools
export PATH="/usr/local/sbin:$PATH"                         # Homebrew
export PATH="$HOME/.poetry/bin:$PATH"                       # poetry
# pyenv specific:
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# export PATH="/usr/local/lib/python3.9/site-packages:$PATH"  # python

################################################################################
# Prompt
################################################################################

# weird UTF compiler flags
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# prompt data functions
get_git_branch_name() {
    BRANCH_NAME=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    [[ -n "$BRANCH_NAME" ]] && echo "\UE0A0 ${BRANCH_NAME}"
}

get_env_name() {
    if [[ -n "$PIPENV_ACTIVE" ]]; then
        GREEN=$'%{\e[38;2;158;206;106m%}'
        VIRTUAL_ENV_NAME="${VIRTUAL_ENV##*/}"
        echo "$GREEN\U2699 ${VIRTUAL_ENV_NAME:0:-9}"
    elif [[ -n "$VIRTUAL_ENV" ]]; then
        GREEN=$'%{\e[38;2;158;206;106m%}'
        echo "$GREEN\U2699 ${VIRTUAL_ENV##*/}"
    fi
}

get_working_info() {
    BLUE='%{\e[38;2;122;162;247m%}'
    GIT_BRANCH_NAME="$(get_git_branch_name | xargs)"
    GIT_BRANCH_NAME_STYLED="$BLUE$GIT_BRANCH_NAME"
    ENV_NAME="$(get_env_name)"
    BLANK=$'%{\e[0m%}'
    if [[ (-n $GIT_BRANCH_NAME) && (-n $ENV_NAME) ]]; then
        echo "[$GIT_BRANCH_NAME_STYLED $ENV_NAME$BLANK] "
    elif [[ -n $GIT_BRANCH_NAME ]]; then
        echo "[$GIT_BRANCH_NAME_STYLED$BLANK] "
    elif [[ -n $ENV_NAME ]]; then
        echo "[$ENV_NAME$BLANK]"
    fi
}

setopt PROMPT_SUBST
if [[ -z "${ALACRITTY_LOG}" ]]; then
    # don't use truecolor in mac terminal
    PROMPT='%9c%{%F{blue}%} ($(get_git_branch_name))%{%F{none}%} %% '
else
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    BLANK=$'%{\e[0m%}'
    GREEN=$'%{\e[38;2;158;206;106m%}'
    RED=$'%{\e[38;2;219;75;75m%}'
    PROMPT=$'$(get_working_info)%3c %(?.%{$GREEN%}.%{$RED%})%%$BLANK '
fi
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
alias trc="tree -AC -I '__pycache__|*.egg-info|build|dynamodb_local'"
alias gtrc="git ls-tree -r --name-only HEAD | tree --fromfile"

# open journal
alias journal='nvim /Users/jss/code/journal.md'

# fix weird public wifi hotspot stuff
alias clean_net_config='sudo rm /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist;
sudo rm /Library/Preferences/SystemConfiguration/com.apple.network.identification.plist;
sudo rm /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist;
sudo rm /Library/Preferences/SystemConfiguration/preferences.plist;
echo "now restarting....";
sudo shutdown -r now'

# readable PATH
alias printpath="tr ':' '\n' <<< '$PATH'"

# finder helpers
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

################################################################################
# Appearance
################################################################################

# if [[ "$TERM_PROGRAM" = "iTerm.app" || "$TERM_PROGRAM" = "alacritty" ]]; then
#     # default value
#     if [ -z ${DARKMODE+x} ]; then
#         export BAT_THEME="ansi"
#         export DARKMODE=1;
#         gsed -i 's/colors: \*light/colors: \*dark/' /Users/jss/code/dotfiles/alacritty.yml
#     fi

#     # swap light/dark colors
#     switchbg() {
#         if [[ "$DARKMODE" -eq 1 ]]; then
#             if [[ "$LC_TERMINAL" == "iTerm2"  ]]; then
#                 echo -e "\033]50;SetProfile=solarized-light\a";
#             elif [[ "$TERM_PROGRAM" == "alacritty" ]]; then
#                 gsed -i 's/colors: \*dark/colors: \*light/' /Users/jss/code/dotfiles/alacritty.yml
#             fi
#             export DARKMODE=0;
#             export BAT_THEME="Solarized (light)";
#         elif [[ "$DARKMODE" -eq 0 ]]; then
#             if [[ "$LC_TERMINAL" == "iTerm2"  ]]; then
#                 echo -e "\033]50;SetProfile=solarized-dark\a";
#             elif [[ "$TERM_PROGRAM" == "alacritty" ]]; then
#                 gsed -i 's/colors: \*light/colors: \*dark/' /Users/jss/code/dotfiles/alacritty.yml
#             fi
#             export DARKMODE=1;
#             export BAT_THEME="Solarized (dark)";
#         else
#             1>&2 echo "Unexpected DARKMODE value: $DARKMODE"
#         fi;
#     }

#     # tmux hook should render this unnecessary, but just in case:
#     if [ -n "$TMUX" ]; then
#         function refresh {
#             darkmode_setting=$(tmux show-environment | grep "^DARKMODE");
#             battheme_setting=$(tmux show-environment | grep "^BAT_THEME");
#             if [[ -n "$darkmode_setting" ]]; then
#                 export "$darkmode_setting"
#             else
#                 echo "Tmux couldn't get darkmode setting";
#             fi

#             if [[ -n "$battheme_setting" ]]; then
#                 export "$battheme_setting";
#             else
#                 echo "Tmux couldn't get bat theme setting";
#             fi
#         }
#     else
#         function refresh { }
#     fi
# elif [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
#     export BAT_THEME="GitHub"
# fi

# function tmux_send_nvim_keys() {
#     for _pane in $(tmux list-panes -a -F '#{pane_id}'); do
#         if [[ $(tmux display-message -t $_pane -p -F '#{pane_current_command}') = "nvim" ]]; then
#             tmux send-keys -t $_pane Escape ':call SetBackground()' Enter
#         fi
#     done
# }

################################################################################
# Specific tools
################################################################################

# fzf
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'bat --style=numbers --color=always {} | head -500'"

# ghc
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"


# conda
__conda_setup="$('/Users/jss/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jss/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jss/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jss/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# zoxide
eval "$(zoxide init zsh)"

# bat
export BAT_THEME="tokyonight-storm"

################################################################################
# RVM says it should be last, so it's last
################################################################################

export PATH="$PATH:$HOME/.rvm/bin"
