#!/usr/bin/env bash

OSX=$(test "`uname`" == "Darwin" && echo "x")

if [[ OSX ]]; then

    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until `.osx` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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

    echo "Doneskies."

else
    echo "Skipping."
fi
