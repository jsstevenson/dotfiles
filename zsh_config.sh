#!/bin/zsh

################################################################################
# Prompt
################################################################################

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
    blank=$'%{\e[0m%}'
    green=$'%{\e[38;2;158;206;106m%}'
    red=$'%{\e[38;2;219;75;75m%}'
    PROMPT=$'$(get_working_info)%3c %(?.%{$green%}.%{$red%})%%$blank '
fi
export PS2="> "

################################################################################
# Git
################################################################################

# branch autocomplete TODO

################################################################################
# Appearance
################################################################################

export BAT_THEME="ansi"
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

################################################################################
# Specific tools
################################################################################

export EDITOR=/usr/local/bin/nvim
export VISUAL=/usr/local/bin/nvim

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

# helper stuff

# readable PATH
alias printpath="tr ':' '\n' <<< '$PATH'"

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
alias journal='nvim /Users/jss009/journal.md'

# open current director in Finder
alias f='open -a Finder ./'

# force utf-8 in tmux
alias tmux='tmux -u'

# homebrew catch-all alias
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'


