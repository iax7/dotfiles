[[ -d /opt/homebrew/bin ]] && eval "$(/opt/homebrew/bin/brew shellenv)" # macOS ARM

# Added by Toolbox App
JB_PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
[[ -d "$JB_PATH" ]] && export PATH="$PATH:$JB_PATH"
