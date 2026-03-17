# Files Utils
abbr -a cp 'cp -v'
abbr -a mv 'mv -v'
abbr -a rm 'rm -v'
abbr -a rmd 'rm -rfv'

function get_date; date +%Y-%m-%d; end
function get_datetime; date +%Y-%m-%d_%H:%M:%S; end
function get_pbpaste; pbpaste; end
function get_folder; basename (pwd); end

# Gloabl "aliases"
abbr -a \?  --position anywhere " -h 2>&1 | bat -plhelp"
abbr -a \?\? --position anywhere -- "--help 2>&1 | bat --language=help --style=plain"
abbr -a B64 --position anywhere "| base64"
abbr -a D64 --position anywhere "| base64 -d"
abbr -a C   --position anywhere "| pbcopy"
abbr -a P   --position anywhere --function get_pbpaste
abbr -a DT  --position anywhere --function get_date
abbr -a DH  --position anywhere --function get_datetime
abbr -a FN  --position anywhere --function get_folder
abbr -a NE  --position anywhere "2>/dev/null"
abbr -a ND  --position anywhere ">/dev/null"
abbr -a NIL --position anywhere ">/dev/null 2>&1"
abbr -a S   --position anywhere "| sort"
abbr -a H   --position anywhere --set-cursor "!" "| head -n !"
abbr -a T   --position anywhere --set-cursor "!" "| tail -n !"
abbr -a V   --position anywhere -- "--version"
