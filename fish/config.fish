# Path to Oh My Fish install.
source ~/.config/fish/prompt.fish
set -gx OMF_PATH /Users/montanaflynn/.local/share/omf

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG /Users/montanaflynn/.config/omf

# Golang path setting
set -gx GOPATH ~/Development/go/

# Set z path
set -g Z_SCRIPT_PATH /usr/local/Cellar/z/1.9/etc/profile.d/z.sh

# Helpers
source ~/.config/fish/aliases.fish

# Add completeion for git alias
make_completion g 'git'

# Remove fish welcome message
set -e fish_greeting

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
