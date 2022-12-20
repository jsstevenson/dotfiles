#!/bin/zsh
################################################################################
# Hotkeys
################################################################################

if [[ -n "$TMUX" ]]; then
    bindkey "^[[1;3C" forward-word
    bindkey "^[[1;3D" backward-word
fi

################################################################################
# Prompt
################################################################################

# prompt data functions
get_git_branch_name() {
    BRANCH_NAME=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [[ $TERM_PROGRAM == "Apple_Terminal" || $TERM_PROGRAM == "vscode" ]]; then
        GIT_LOGO=""
    else
        GIT_LOGO="\UE0A0 "
    fi
    [[ -n "$BRANCH_NAME" ]] && echo "${GIT_LOGO}${BRANCH_NAME}"
}

get_env_name() {
    if [[ -n "$POETRY_ACTIVE" ]]; then
        GREEN=$'%{\e[38;2;158;206;106m%}'
        VIRTUAL_ENV_NAME="${VIRTUAL_ENV##*/}"
        echo "$GREEN\U2699 ${VIRTUAL_ENV_NAME:0:-16}"
    elif [[ -n "$PIPENV_ACTIVE" ]]; then
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
if [[ $TERM_PROGRAM != "Apple_Terminal" && $TERM_PROGRAM != "vscode" ]]; then
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    blank=$'%{\e[0m%}'
    green=$'%{\e[38;2;158;206;106m%}'
    red=$'%{\e[38;2;219;75;75m%}'
    PROMPT=$'$(get_working_info)%3c %(?.%{$green%}.%{$red%})%%$blank '
else
    # don't use truecolor/icons in mac or vscode terminals
    PROMPT='%9c%{%F{blue}%} ($(get_git_branch_name))%{%F{none}%} %% '
fi
export PS2="> "

################################################################################
# Git
################################################################################

# branch autocomplete TODO

################################################################################
# Appearance
################################################################################

# if [[ "$TERM_PROGRAM" = "iTerm.app" || "$TERM_PROGRAM" = "alacritty" ]]; then
#     # default values
#     if [ -z ${DARKMODE+x} ]; then
#         export BAT_THEME="ansi"
#         export DARKMODE=1;
#         gsed -i 's/colors: \*solarized_light/colors: \*solarized_dark/' /Users/jss009/dotfiles/alacritty.yml
#     fi

#     # swap light/dark colors
#     switchbg() {
#         if [[ "$DARKMODE" -eq 1 ]]; then
#             if [[ "$LC_TERMINAL" == "iTerm2"  ]]; then
#                 echo -e "\033]50;SetProfile=solarized-light\a";
#             elif [[ "$TERM_PROGRAM" == "alacritty" ]]; then
#                 gsed -i 's/colors: \*solarized_dark/colors: \*solarized_light/' /Users/jss009/dotfiles/alacritty.yml
#             fi
#             export DARKMODE=0;
#             export BAT_THEME="Solarized (light)";
#         elif [[ "$DARKMODE" -eq 0 ]]; then
#             if [[ "$LC_TERMINAL" == "iTerm2"  ]]; then
#                 echo -e "\033]50;SetProfile=solarized-dark\a";
#             elif [[ "$TERM_PROGRAM" == "alacritty" ]]; then
#                 gsed -i 's/colors: \*solarized_light/colors: \*solarized_dark/' /Users/jss009/dotfiles/alacritty.yml
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

# bat
export BAT_THEME="tokyonight-storm"

################################################################################
# Commands and settings
################################################################################

export EDITOR=/usr/local/bin/nvim
export VISUAL=/usr/local/bin/nvim

# readable PATH
alias printpath="tr ':' '\n' <<< '$PATH'"

# combined cd and show directory (exa)
function cd {
    builtin cd "$@" && exa
}

# colorize and append size measures
alias ll='exa -l'

# default tree args
alias trc="tree -AC -I '__pycache__|*.egg-info|build|dynamodb_local|dist'"
alias gtrc="git ls-tree -r --name-only HEAD | tree --fromfile"

# open journal
if (( ${+JOURNAL_LOCATION} )); then
    alias journal="nvim ${JOURNAL_LOCATION}"
else
    alias journal="echo 'env var JOURNAL_LOCATION unset'"
fi

# open current director in Finder
alias f='open -a Finder ./'

# force utf-8 in tmux
alias tmux='tmux -u'

# homebrew catch-all alias
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# fzf
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'bat --style=numbers --color=always {} | head -500'"

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# procs alias
alias prc='procs'
