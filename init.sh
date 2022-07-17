#!/usr/bin/env bash
# If links fails (on macOS which uses FBSD) use: find . -maxdepth 1 -type l -delete
RED="\e[31m"
GRE="\e[32m"
BLU="\e[34m"
RST="\e[0m"
ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

INIT_FILES_DIR="rc"

title() {
  echo -e "[ ${BLU}$1$RST ]────────────────────────────────────────────────────"
}

# param 1 -> source name
# param 2 -> destination name - if missing source name will be used
create_link(){
  local file_name="$1"
  local link_path="$2"
  source_file="$ABSDIR/$file_name"

  if [[ -z "$link_path" ]]; then
    link_path=~/"$file_name"
  else
    link_path=~/"$link_path"
  fi
  #echo "source: $source_file | link: $link_path" && exit 1

  if [[ ! -e "$link_path" ]]; then
    ln -fs "$source_file" "$link_path" 2>/dev/null
    [[ $? -eq 0 ]] && echo -e "  ${GRE}NEW$RST, $source_file --> $GRE$link_path$RST" || \
                      echo -e "${RED}Error$RST, $GRE$source_file$RST does not exist."
  else
    type=$(stat -c%F "$link_path")
    type_fmt="$type             "
    [[ $type == 'directory' || $type == 'regular file' ]] && _color="$RED" || _color="$BLU"
    echo -e "   OK, $_color${type_fmt:0:13}$RST --> $GRE$link_path$RST already exists."
  fi
}

echo -e "${GRE}Creating links...$RST"
# Manual linking
create_link bin
create_link vendor/LS_COLORS/LS_COLORS .dir_colors

# Automatic linking
for to_link in $(ls -A $INIT_FILES_DIR); do
  create_link "$INIT_FILES_DIR/$to_link" $to_link
done

echo
echo -e "${GRE}Executing initialization scripts...$RST"
# Running init.d scripts
for script in $(ls init.d); do
  title "$script"
  exec "init.d/$script"
done