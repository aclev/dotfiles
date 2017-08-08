#!/bin/sh

# path to the dotfiles repo.
DOTFILES=~/.dotfiles

if [ ! -e /Applications/iTerm.app ]
then
    echo "Could not find iTerm, downloading"
    curl -o ~/iterm.zip https://iterm2.com/downloads/stable/iTerm2-3_0_15.zip
    unzip ~/iterm.zip
    mv ~/iTerm.app /Applications/iTerm.app
    rm ~/iterm.*
    echo "Installed iTerm"
fi

if [ ! -x /usr/local/bin/brew ]
then
    echo "Could not find brew, installing"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Installed brew"
fi

if [ ! -e /usr/local/bin/fish ]
then
    echo "Could not find fish, installing"
    brew install fish
    chsh -s /usr/local/bin/fish
    echo "Installed fish"
fi

if [ ! -e /usr/local/bin/tmux ]
then
    echo "Could not find tmux, installing"
    brew install tmux
    echo "Installed tmux"
fi

if which vim | grep '/usr/bin/vim'
then
    echo "default vim installed, installing MacVim"
    brew install macvim --with-override-system-vim
    echo "Installed MacVim"
fi

if [ ! -f ~/.vim/autoload/plug.vim ]
then 
    echo "Could not find vim-plug, installing"
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "installed vim plug"
fi

if ! which reattach-to-user-namespace > /dev/null
then 
    echo "Installing reattach-to-user-namespace"
    brew install reattach-to-user-namespace
    echo "installed reattach-to-user-namespace"
fi

if ! which go > /dev/null
then
    echo "Couldn't find go, installing"
    brew install go
    echo "installed go"
fi

if [ ! -d ~/go ]
then
    echo "Creating go dir"
    mkdir ~/go
fi

if [ ! -d $DOTFILES ]
then
    echo "Could not find dotfiles, cloning repo now"
    mkdir $DOTFILES
    git clone git@github.com:aclev/dotfiles.git $DOTFILES
    echo "cloned dotfiles"
fi

# Check for dotfiles again to make sure it succeeded downloading before we use it.
if [ -d $DOTFILES ]
then
    # Create symlinks for each file in the .dotfiles dir.
    for file in $DOTFILES/.*
    do
        filename=$(basename $file)
        # Don't check for a few files
        if [ ! $filename == "." ] &&
           [ ! $filename == ".." ] &&
           [ ! $filename == ".git" ]
        then
            if [ ! -L ~/$filename ]
            then
                echo "creating symlink for $filename"
                ln -s file ~/$filename
            fi
        fi
    done
fi
