#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl unzip getopt

set -eEu

# utils
function fail() {
  echo $1 >&2
  exit 1
}

# check requirements
CODIUM=$(command -v codium)
if [ -z $CODIUM ]; then 
  fail "codium not found!"
fi

# setup
cd $(dirname $0)

readonly SCRIPT_NAME=${0##*/}

TMP_DIR=$(mktemp -d -t ext_XXXXX)
trap "rm -rf $TMP_DIR" ERR EXIT

readonly EXT_DIR=$HOME/.vscode-oss/extensions
if [ ! -d $EXT_DIR ]; then
  mkdir -p $EXT_DIR
fi

# code
function add_latest() {
  PUBLISHER=$1
  NAME=$2
  FILE_NAME="$1.$2"
  URL="https://$PUBLISHER.gallery.vsassets.io/_apis/public/gallery/publisher/$PUBLISHER/extension/$NAME/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
  curl --silent --show-error --fail -X GET -o $TMP_DIR/$FILE_NAME.zip $URL || fail "Download failed"
  unzip -qq $TMP_DIR/$FILE_NAME.zip -d $TMP_DIR
  mkdir -p $EXT_DIR/$FILE_NAME
  mv $TMP_DIR/extension/* $EXT_DIR/$FILE_NAME
  echo "Successfully added $FILE_NAME"
}

function add() {
  PUBLISHER=$(echo $1 | cut -d. -f1)
  NAME=$(echo $1 | cut -d. -f2)
  echo "Publisher: $PUBLISHER, Name: $NAME"
  add_latest $PUBLISHER $NAME
}

function print_help() {
  cat << EOF


Usage: $SCRIPT_NAME [OPTION]

    -a, --add=<ExtPublisher>.<ExtName>
    -h, --help


Example:

    $SCRIPT_NAME -a bbenoist.nix
    $SCRIPT_NAME -h
EOF
}

# entry point
PARAMS=$(getopt -n $SCRIPT_NAME \
  -o a:h \
  -l add:,help \
  -- $@)

if [ $# -lt 1 ]; then
  fail "Try '$SCRIPT_NAME --help' for more information"
fi

eval set -- $PARAMS

add=""

while true
do
  case $1 in
    -a | --add)
      add=$2
      shift 2
      ;;
    -h | --help)
      print_help
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      fail "Invalid option"
      ;;
    esac
  done

if [ -n $add ]; then
  add $add
else 
  print_help
fi
