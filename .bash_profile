# grab git branch for prompt
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# prompt
export PS1="\W: \u @ \h\[\033\]\[[0;34m\]\$(parse_git_branch)\[\033[00m\] \$ "
export PS2="> "

# Set default editor to NeoVIM
export EDITOR=~/nvim.appimage

# Combine cd and ls
combined_cd_ls() {
    if [[ $# -eq 1 ]]; then
        cd "$1"
        ls
    else
        cd ~
        ls
    fi
}

alias cd='combined_cd_ls'

# get full path of file
getpath() {
	ls "`pwd`/$1"
}

# shortcut for local vim image (hopefully doesn't break anything)
alias nvim='~/nvim.appimage'
