function mkcd -d "Create a directory and enter it"
    mkdir -p $argv; and cd $argv
end
function cx -d "Change directory and list files"
    cd $argv; and ll
end

# Navigation
alias ..  "cd .."
alias ... "cd ../.."

# ----------[ Command aliasses ]------------------------------------------------
type -q lazygit; and alias lg lazygit
type -q lazydocker; and alias lzd lazydocker
type -q ip; and alias ip "ip -c"
# mise - https://github.com/jdx/mise --
if type -q mise
  alias ml 'mise list'
  alias mD 'mise doctor'
  alias mO 'mise outdated'
  alias mi 'mise install'   # mise i
  # alias mu 'mise use' Installs a tool and adds the version to mise.toml. [aliases: u]
  alias mU 'mini_t self-update && mise self-update --yes --cd ~ && mini_t update && mise up --cd ~'
  alias mu 'mise upgrade --bump -i' # mise up
  alias mx 'mise exec --'   # mise x --
  alias mr 'mise run'       # mise r
  alias mR 'mise uninstall' # mise rm
end
# EZA - https://eza.rocks/ ------------
if type -q eza
  alias eza 'eza --icons --group-directories-first --header'
  alias l 'eza -HlgF --git --color-scale'
  alias ll 'l -aa'
  alias lt "eza --tree --git-ignore -L2"
  alias l1 'eza -1 --no-quotes --no-symlinks --group-directories-first'
else # LS Fallback
  alias ls 'ls --color=auto'
  alias ll 'ls -halF'
  alias lt 'tree --gitignore --dirsfirst'
end
# NeoVIM - https://neovim.io/ ---------
if type -q nvim
  alias v 'nvim'
  alias v. 'nvim .'
end
# Docker - https://www.docker.com/get-started
if type -q docker
  abbr -a d   'docker'
  abbr -a dps 'docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'  # List all containers
  abbr -a dP  'docker ps --format "table {{.Ports}}\t{{.Names}}"'
  abbr -a d.  'docker start'   # Start a container
  abbr -a d-  'docker stop'    # Stop a container
  abbr -a d,  'docker restart' # Restart a container
  abbr -a dl  'docker logs -f' # Follow container logs
  abbr -a dp  'docker system prune --volumes'
  # Docker compose
  abbr -a dcu 'docker compose up -d'
  abbr -a dcd 'docker compose down'
  abbr -a dcp 'docker compose ps'
end
