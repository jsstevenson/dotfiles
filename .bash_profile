### Python
# Setting PATH for Python 3.6
# Fixing previous install which used PATH=/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}
# Would need to omit for any non-personal machines
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:~/bin #add local scripts folder
export PATH=$PATH:'~/../../Applications/Racket v7.1/bin' # add racket
export PATH=$PATH:/Users/jamesstevenson/.gem/ruby/2.3.0/bin

### Git
# completion
source ~/.git-completion.bash

### Prompt
# grab git branch
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# prompt
export PS1="\W: \u @ \h\[\033\]\[[0;34m\]\$(parse_git_branch)\[\033[00m\] \$ "
export PS2="> "

### Defaults/aliases
# Set default editor to NeoVIM
export EDITOR=/usr/local/bin/nvim

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

# open current director in Finder
alias f='open -a Finder ./'

# homebrew catch-all alias
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# get full path of file
getpath() {
	ls "`pwd`/$1"
}

# tmuxinator https://github.com/tmuxinator/tmuxinator
source ~/.bin/tmuxinator.bash

export PATH="$HOME/.cargo/bin:$PATH"
