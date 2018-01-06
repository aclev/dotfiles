#!/bin/sh

# path to the dotfiles repo.
DOTFILES=~/.dotfiles

# All of the packages that are installed via brew.
BREW_PACKAGES=(fish nvim vault awscli tmux leiningen go cmake reattach-to-user-namespace jq watch grip rlwrap)

isBrewPackageInstalled()
{
    p=$1
    if [ $p == "leiningen" ]; then
        p=lein
    fi
    if [ $p == "awscli" ]; then
        p=aws
    fi
    which $p > /dev/null
    return $?
}


if [ ! -e /Applications/Docker.app ]; then
    echo "Could not find Docker, downloading"
    curl -o ~/docker.dmg https://download.docker.com/mac/stable/Docker.dmg
    hdiutil attach ~/docker.dmg
    cp -r /Volumes/Docker/Docker.app /Applications
    hdiutil detach /Volumes/Docker
    rm ~/docker.dmg
    echo "Installed docker to appliations folder"
fi

# Install pip

if ! which pip 1> /dev/null ; then
    echo "Pip Install installed, installing it.  It will required a passwrod"
    sudo easy_install pip
fi

# Neovim python support.

if [ ! -e ~/Library/Python/2.7/lib/python/site-packages/neovim ]; then
    echo "Couldn't find nvim install"
    pip2 install --user neovim
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

if [ ! -e /Applications/iTerm.app ]; then
    echo "Couldn't find iTerm, installing"
    brew cask install iterm
    echo "Installed iterm"
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

if [ ! -e ~/.config/omf ]; then
    echo "Could not find oh my fish, installing"
    curl -L http://get.oh-my.fish | fish
    echo "Installed oh my fish"
fi

for package in "${BREW_PACKAGES[@]}"; do
    if ! isBrewPackageInstalled $package; then
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
