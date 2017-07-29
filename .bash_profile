export GOPATH=$HOME/golang
alias mvim="/Apllications/MacVim.app/Contents/MacOS/Vim"

export NVM_DIR=~/.nvm
  . $(brew --prefix nvm)/nvm.sh


removeTabs(){
    ruby -pe '$_.gsub!(/\t/,"    ")' < $argv[0] > $argv[1].new
    mv $argv[0].new $argv[0]
}    

gitAddRemoveTabs() {
    removeTabs $1
    git add $1
}

alias retab=removeTabs
alias gant=gitAddRemoveTabs

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export PATH=$GOPATH/bin:$HOME/tools:$(brew --prefix nginx)/bin/:$HOME/.rbenv/shims/:$HOME/.cargo/bin:/Apllications/MacVim.app/Contents/MacOS:$HOME/$PATH

eval "$(rbenv init -)"

if command -v tmux>/dev/null; then
              [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

source $HOME/.cargo/env

exec fish
eval $(/usr/libexec/path_helper -s)
