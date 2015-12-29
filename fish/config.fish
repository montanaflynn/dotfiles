# Remove fish welcome message
set -e fish_greeting

# Path to Oh My Fish install.
set -gx OMF_PATH ~/.local/share/omf

# Set GOPATH
set -gx GOPATH ~/Development/go/

# Golang bin in path
set --universal fish_user_paths $fish_user_paths $GOPATH/bin/

# Set z path
set -g Z_SCRIPT_PATH /usr/local/Cellar/z/1.9/etc/profile.d/z.sh

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Nice powerline prompt
source ~/.config/fish/prompt.fish

# Helpers
source ~/.config/fish/aliases.fish

# Add completeion for git alias
make_completion g 'git'
