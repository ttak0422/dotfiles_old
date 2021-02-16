#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq unzip getopt

cd `dirname $0`
SCRIPT_NAME=${0##*/}

function fail() {
    echo "$1" >&2
    exit 1
}

CODE=$(command -v code)
if [ -z "$CODE" ]; then 
    fail "vscode not found!"
fi

NIV=$(command -v niv)
if [ -z "$NIV" ]; then
    fail "niv not found!"
fi

function clean_up() {
    echo "cleaning up..."
    rm -rf "/tmp/vscode_exts_*"
}

function print_help() {
    cat << EOF


##############################################
# VSCode must be restarted to apply changes! #
##############################################


Usage: $SCRIPT_NAME [OPTION]

    -s, --sync                            synchronize with VSCode (add only).
    -a, --add=<Publisher>.<ExtensionName> add package. 
    -u, --update                          update extensions.
    -h, --help                            display this help and exit.


Example:

    $SCRIPT_NAME -s
    $SCRIPT_NAME -a bbenoist.nix
    $SCRIPT_NAME -u
EOF
}

function add_ext() {
    N="$1.$2"
    EXT_TEMP=$(mktemp -d -t vscode_exts_XXXXXXXX)
    URL="https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
    # TODO: check status code.
    curl --silent --show-error --fail -X GET -o "$EXT_TEMP/$N.zip" "$URL"
    VER=$(jq -r '.version' <(unzip -qc "$EXT_TEMP/$N.zip" "extension/package.json"))
    rm -Rf "$EXT_TEMP"
    URL_TPL="https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/<version>/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
    echo "name: $2, version: $VER, tpl: $URL_TPL"
    $NIV -s ./nix/vscode.json add "$2" -o "$1" -v "$VER" -t "$URL_TPL"
}

function sync() {
    declare -A exts 
    trap clean_up SIGINT

    for ext in $($NIV -s ./nix/vscode.json show --no-colors); do
        exts[$ext]="contains"
    done

    for ext in $($CODE --list-extensions); do 
        OWNER=$(echo $ext | cut -d. -f1)
        EXT=$(echo $ext | cut -d. -f2)
        if [ -z "${exts["$EXT"]}" ]; then
            echo "not exist"
            add_ext "$OWNER" "$EXT" 
        fi
    done
}

function add() {
    OWNER=$(echo $1 | cut -d. -f1)
    EXT=$(echo $1 | cut -d. -f2)
    echo "Owner: $OWNER, Ext: $EXT"
    add_ext "$OWNER" "$EXT"
}

params=$(getopt -n "$SCRIPT_NAME" \
    -o sa:uh \
    -l sync,add:,update,help \
    -- "$@")

if [[ $? -ne 0 ]]; then 
    fail "Try --help option for more information"
fi 
eval set -- $params

sync=
add=
update=

while true
do
    case $1 in
        -s | --sync)
            sync=true
            shift
            ;;
        -a | --add)
            add=$2
            shift 2
            ;;
        -u | --update)
            update=true
            shift
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
            fail "Internal error!"
            ;;
    esac
done

if [[ -n $sync ]]; then
    sync
elif [[ -n $add ]]; then
    add "$add"
elif [[ -n $update ]]; then
    echo "wip..."
else 
    print_help
fi
