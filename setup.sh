#!/usr/bin/env bash

#########################################################################################
### Monty's OSX Setup Script
### https://github.com/montanaflynn/dotfiles/blob/master/setup.sh
#########################################################################################

# Ask for the administrator password upfront and update
# existing `sudo` time stamp until `.osx` has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#########################################################################################
### XCode Command Line Tools
### https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh
#########################################################################################
if ! xcode-select --print-path &> /dev/null; then

    # Install XCode and the Command Line Tools
    xcode-select --install

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13
    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10
    sudo xcodebuild -license accept

fi

#########################################################################################
### OSX Defaults that I've been collecting for awhile...
### http://montanaflynn.me/2012/07/osx/osx-screenshot-utility-shortcuts-hacks/
#########################################################################################

# Save screenshots to a new location (make sure directory exists first)
defaults write com.apple.screencapture location ~/Pictures/Screenshots/

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Disable screenshot shutter sound (and empty trash sound)
defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Always open everything in Finder's list view. This is important
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the path bar in finder windows
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Set a really fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 0

# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Set up Safari for development
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Disable smart quotes and dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# To enable any changes you must kill em all
for app in "Finder" "SystemUIServer" "Safari"; do
    killall "${app}" > /dev/null 2>&1
done

#########################################################################################
### Install Homebrew, Homebrew Cask & Cask Versions
### This nice concoction of brew allows us to easily imbibe in our software addiction
#########################################################################################

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Homebrew Cask
mute brew install caskroom/cask/brew-cask

# Homebrew Cask Versions
brew tap caskroom/versions

# Install brews
brews=(
  fish
  lame
  node
  speedtest_cli
  wget
  z
  ccat
  git
  libevent
  openssl
  thefuck
  x264
  ffmpeg
  htop-osx
  libvo-aacenc
  siege
  tmux
  xvid
  coreutils
  findutils
  gcc
  vim
  imagemagick
  ffmpeg
)

for brew in "${brews[@]}"
do
  echo "Installing $brew"
  brew install $brew
done

# Install apps
apps=(
  spotify
  google-chrome
  mou
  sublime-text
  tomighty
  clipmenu
  atom
  iterm2
  slack
  clipmenu
  iterm2-beta
  spectacle
  firefoxdeveloperedition
  komanda
  telegram
  flux
  google-chrome
  monodraw
  the-unarchiver
  google-cloud-sdk
  quicksilver
  vlc
)

for app in "${apps[@]}"
do
  brew cask install --appdir="/Applications" $app
done

# Install cask fonts
echo "Installing some caskroom/fonts"
brew tap caskroom/fonts

fonts=(
  font-roboto
  font-open-sans
  font-lato
  font-alegreya
  font-montserrat
  font-inconsolata
  font-quicksand
  font-raleway
  font-ubuntu
  font-hack
  font-meslo-lg-for-powerline
  font-sauce-code-powerline
)

# Install the fonts
echo "Installing the fonts"
brew cask install ${fonts[@]}

echo "Doneskies."
