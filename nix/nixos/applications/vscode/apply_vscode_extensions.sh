#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq unzip

function fail() {
    echo "$1" >&2
    exit 1
}

function clean_up() {
    echo "cleaning up..."
    rm -rf "/tmp/vscode_exts_*"
}

function add_ext() {
    N="$1.$2"
    EXT_TEMP=$(mktemp -d -t vscode_exts_XXXXXXXX)
    URL="https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
    curl --silent --show-error --fail -X GET -o "$EXT_TEMP/$N.zip" "$URL"
    VER=$(jq -r '.version' <(unzip -qc "$EXT_TEMP/$N.zip" "extension/package.json"))
    rm -Rf "$EXT_TEMP"
    URL_TPL="https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/<version>/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
    echo "name: $2, version: $VER, tpl: $URL_TPL"
    niv add "$2" -o "$1" -v "$VER" -t "$URL_TPL"
}

CODE=$(command -v code)
declare -A exts 

if [ -z "$CODE" ]; then 
  fail "vscode not found!"
fi

trap clean_up SIGINT

for ext in $(niv show | grep "^\S.*$" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"); do
    exts[$ext]="contains"
done

for ext in $($CODE --list-extensions); do 
    OWNER=$(echo $ext | cut -d. -f1)
    EXT=$(echo $ext | cut -d. -f2)
    if [ -z "${exts["$OWNER-$EXT"]}" ]; then
        echo "not exist"
        add_ext "$OWNER" "$EXT" 
    fi
done
