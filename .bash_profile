export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"

alias vimrc="vim $HOME/.vimrc"
alias profile="vim $HOME/.bash_profile"
alias python='python3'

set editing-mode vim

export PATH="/Users/acelevenberg/.cargo/bin:/usr/local/bin:./:$HOME/.cabal/bin:$HOME/Library/Haskell/bin:$HOME/.vim/bundle/syntastic/syntax_checkers/python:/Applications/MacVim-snapshot-73/:$GOPATH/bin:$GOROOT/bin:$PATH"
export RUST_SRC_PATH="/Users/acelevenberg/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=$WORKON_HOME

export PATH

[ -s "/Users/acelevenberg/.dnx/dnvm/dnvm.sh" ] && . "/Users/acelevenberg/.dnx/dnvm/dnvm.sh" # Load dnvm

if command -v tmux>/dev/null; then
          [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi
exec fish
