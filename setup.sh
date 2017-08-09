#!/bin/sh

# path to the dotfiles repo.
DOTFILES=~/.dotfiles

# All of the packages that are installed via brew.
BREW_PACKAGES=(fish tmux leiningen go cmake reattach-to-user-namespace jq watch grip)

if [ ! -e /Applications/iTerm.app ]; then
    echo "Could not find iTerm, downloading"
    curl -o ~/iterm.zip https://iterm2.com/downloads/stable/iTerm2-3_0_15.zip
    unzip ~/iterm.zip
    mv ~/iTerm.app /Applications/iTerm.app
    rm ~/iterm.*
    echo "Installed iTerm"
fi

# Make iterm read preferences from the dotfiles dir instead of /Application Support
# iTerm2 just checks in the user defaults for LoadPrefsFromCustomFolder, which doesn't 
# exist if false.  So just check to make sure that default is set, if it isn't set it
# and also set the location of the settings file 

defaults read com.googlecode.iterm2.plist LoadPrefsFromCustomFolder | grep "0" 2> /dev/null 
if [ $? == 0 ]; then
    echo "Iterm isn't reading from settings directory, setting it to read from ~/.dotfiles/settings/ now"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder 1
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder ~/.dotfiles/settings/
    echo "Done setting iTerm prefs"
fi

if [ ! -x /usr/local/bin/brew ]; then
    echo "Could not find brew, installing"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Installed brew"
fi

if which vim | grep '/usr/bin/vim'; then
    echo "default vim installed, installing MacVim"
    brew install macvim --with-override-system-vim
    echo "Installed MacVim"
fi

if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Could not find vim-plug, installing"
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "installed vim plug"
fi

for package in "${BREW_PACKAGES[@]}"; do
    if ! which $package > /dev/null; then
        echo "Cound't find $package, installing with brew"
        brew install $package
        echo "Installed $package"
    fi
done

if [ ! -d ~/go ]; then
    echo "Creating go dir"
    mkdir ~/go
fi

if [ ! -d $DOTFILES ]; then
    echo "Could not find dotfiles, cloning repo now"
    mkdir $DOTFILES
    git clone git@github.com:aclev/dotfiles.git $DOTFILES
    echo "cloned dotfiles"
fi

# Check for dotfiles again to make sure it succeeded downloading before we use it.
if [ -d $DOTFILES ]; then
    # Create symlinks for each file in the .dotfiles dir.
    for file in $DOTFILES/.*; do
        filename=$(basename $file)
        # Don't check for a few files
        if [ ! $filename == "." ] &&
           [ ! $filename == ".." ] &&
           [ ! $filename == ".gitignore" ] &&
           [ ! $filename == "settings" ] &&
           [ ! $filename == ".git" ]; then
            if [ ! -L ~/$filename ] && [ ! -f ~/$filename ]; then
                echo "creating symlink for $filename"
                ln -s $file ~/$filename
            fi
        fi
    done
fi
