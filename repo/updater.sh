#!/usr/bin/env bash

# Update the contents of this repository
# AUTHOR: Jared Dyreson

export EMAIL="jareddyreson@csu.fullerton.edu"
export USERNAME="JaredDyreson"
export KEYNAME="$(gpg --fingerprint | egrep -B1 'Jared Dyreson' | head -n1 |  sed -e 's/\s//g'| cut -d "=" -f2)"
export HOME_DIR="$PWD"
export BUILD_DIR="$PWD/amd64/builds"

function dir_dne(){
  echo "[-] Cannot find $1, cowardly refusing!"
  exit
}

function aarch_err_(){
  echo "Please run on a debian machine, detected $(uname -r)"
  exit
}

function rebuild_tuffix() {
    [[ "$(uname -v | grep -i "ubuntu")" ]] || aarch_err_

    TEST_DIR="/tmp/tuffix"

    echo "[INFO] Rebuilding the Tuffix installer"

    [[ -d "$TEST_DIR" ]] && rm -rf "$TEST_DIR"

    git clone https://github.com/mshafae/tuffix "$TEST_DIR"
    cd "$TEST_DIR"
    git checkout "releasebuild"

    PKG_BASE="TuffixInstaller"
    PKG_NAME="Tuffix"
    PKG_ARCH="$(uname -m)"

    [[ ! -d "$PKG_BASE" ]] && dir_dne "$PKG_BASE"

    _pkg_regex="([0-9]+\.[0-9]+)\_([0-9])"
    find "$HOME_DIR"/amd64/ -type f -name '*.deb' | tail -n1 | while read line; do 
        base_="$(basename "$line")"
        if [[ "$base_" =~ $_pkg_regex ]]; then
            # NOTE : whatever is the latest entry in our database
            LATEST_PKG_VERSION="${BASH_REMATCH[0]}"; LATEST_PKG_REVISION="${BASH_REMATCH[1]}"
        else
            # otherwise, we are just starting
            LATEST_PKG_VERSION="1.0"; LATEST_PKG_REVISION="0"
        fi
    done

    _pkg_version_regex="Version:\s+([0-9]+\.[0-9]+)\-([0-9]+)"
    control_contents="$(cat "$PKG_BASE"/DEBIAN/control)"

    if [[ "$control_contents" =~ "$_pkg_version_regex" ]]; then
        CURRENT_PKG_VERSION="${BASH_REMATCH[0]}"; CURRENT_PKG_REVISION="${BASH_REMATCH[1]}"
    fi

    if [[ "$LATEST_PKG_REVISION" -eq "$CURRENT_PKG_REVISION" ]]; then
        echo "[INFO] No need to proceed further, git version renders $CURRENT_PKG_REVISION and database provides $LATEST_PKG_REVISION. Please update git version if you intended to update PPA"
        exit
    fi

    #PKG_REVISION="$(awk '/Version:/ {print $2}' "$PKG_BASE"/DEBIAN/control | cut -d "-" -f1)"
    #CURRENT_VERSION="$(awk '/Version:/ {print $2}' "$PKG_BASE"/DEBIAN/control | cut -d "-" -f2)"
    # NEW_VERSION=$((CURRENT_VERSION+1))
    
    DEB_OUTPUT="$BUILD_DIR"/"$PKG_NAME"_"$CURRENT_PKG_VERSION"_"$CURRENT_PKG_REVISION"_"$PKG_ARCH".deb

    sed -i "s/Version: .*/Version: $CURRENT_PKG_VERSION-$CURRENT_PKG_REVISION/" "$PKG_BASE"/DEBIAN/control

    find "$PKG_BASE" -type f -not -path "*DEBIAN*" -exec chmod 755 {} \;

    echo "[+] Updated TuffixInstaller from revision $LATEST_PKG_REVISION to $CURRENT_PKG_REVISION"

    dpkg-deb --build "$PKG_BASE" "$DEB_OUTPUT"

}


# echo "deb http://$(hostname -I)/repo /"

rebuild_tuffix
# update_deb_folder
