################################################################################
# Path
################################################################################

export PATH="$HOME/.local/bin:$PATH"                        # local binaries
export PATH="/Applications/Julia-1.6.app/Contents/Resources/julia/bin:$PATH"    # Julia
export PATH="$HOME/.cargo/bin:$PATH"                        # Rust tools
export PATH="/usr/local/sbin:$PATH"                         # Homebrew
export PATH="$HOME/.poetry/bin:$PATH"                       # poetry

################################################################################
# Prompt
################################################################################
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

fancy_parse_git_branch() {
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/')
    [[ -n "$branch" ]] && echo " \UE0A0$branch"
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

virtualenv_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="venv"
    else
        venv=''
    fi
    [[ -n "$venv" ]] && echo "%{\e[38;2;31;35;53m%} \UE0B1 %{\e[38;2;192;202;245m%}$venv"
}

setopt PROMPT_SUBST
if [[ -z "${ALACRITTY_LOG}" ]]; then
    # don't use truecolor in mac terminal
    PROMPT='%9c%{%F{blue}%}$(parse_git_branch)%{%F{none}%} %% '
else
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    PROMPT=$'%{\e[38;2;31;35;53;48;2;122;162;247m%}$(fancy_parse_git_branch) %{\e[38;2;122;162;247;48;2;65;72;104m%}\UE0B0%{\e[38;2;192;202;245;48;2;65;72;104m%} %2c$(virtualenv_info) %{\e[38;2;65;72;104;48;2;36;40;59m%}\UE0B0%{\e[0m%} '
    # PROMPT=$'%{\e[38;2;31;35;53;48;2;122;162;247m%}$(fancy_parse_git_branch) %{\e[38;2;122;162;247;48;2;65;72;104m%}\UE0B0%{\e[38;2;192;202;245;48;2;65;72;104m%} %2c$(virtualenv_info) %{\e[38;2;65;72;104;48;2;36;40;59m%}\UE0B0%{\e[0m%} '
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

# zoxide
eval "$(zoxide init zsh)"

# bat
export BAT_THEME="tokyonight-storm"

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


fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
