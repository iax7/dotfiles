[[ -d /opt/homebrew/bin ]] && eval "$(/opt/homebrew/bin/brew shellenv)" # macOS ARM

# Added by Toolbox App
[[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]] && \
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
