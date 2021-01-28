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

function rebuild_tuffix(){
    [[ "$(uname -v | grep -i "ubuntu")" ]] || aarch_err_

    echo "[INFO] Rebuilding the Tuffix installer"

    [[ -d /tmp/tuffix ]] && rm -rf /tmp/tuffix

    cd /tmp
    git clone https://github.com/mshafae/tuffix
    cd tuffix
    git checkout "releasebuild"

    PKG_BASE="TuffixInstaller"
    PKG_NAME="Tuffix"
    PKG_ARCH="$(uname -m)"

    [[ ! -d "$PKG_BASE" ]] && dir_dne "$PKG_BASE"

    PKG_REVISION="$(awk '/Version:/ {print $2}' "$PKG_BASE"/DEBIAN/control | cut -d "-" -f1)"
    CURRENT_VERSION="$(awk '/Version:/ {print $2}' "$PKG_BASE"/DEBIAN/control | cut -d "-" -f2)"
    NEW_VERSION=$((CURRENT_VERSION+1))

    sed -i "s/Version: .*/Version: $PKG_REVISION-$NEW_VERSION/" "$PKG_BASE"/DEBIAN/control

    find "$PKG_BASE" -type f -not -path "*DEBIAN*" -exec chmod 755 {} \;

    echo "[+] Updated TuffixInstaller from version $CURRENT_VERSION to $NEW_VERSION"

    dpkg-deb --build "$PKG_BASE" "$BUILD_DIR"/"$PKG_NAME"_"$PKG_REVISION"_"$NEW_VERSION"_"$PKG_ARCH".deb

}

# echo "deb http://$(hostname -I)/repo /"

rebuild_tuffix
# update_deb_folder
