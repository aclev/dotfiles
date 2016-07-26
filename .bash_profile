export GOPATH=$HOME/golang
alias vim=/usr/local/Cellar/vim/7.4.1257/bin/vim
export PATH=$GOPATH/bin:$HOME/tools:$(brew --prefix nginx)/bin/:$HOME/.rbenv/shims/:$PATH

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

if command -v tmux>/dev/null; then
              [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

[ -s "/Users/ace/.dnx/dnvm/dnvm.sh" ] && . "/Users/ace/.dnx/dnvm/dnvm.sh" # Load dnvm
eval "$(rbenv init -)"
