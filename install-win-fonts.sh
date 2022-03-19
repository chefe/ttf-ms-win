#!/bin/sh

checkIso() {
    if [ ! -f "win${1}.iso" ]; then
        echo "Windows iso (win${1}.iso) not found."
        exit 1
    fi
}

installIfRequired() {
    which "$1" > /dev/null 2>&1
    if [ "$?" -ne 0 ]; then
        sudo pacman -S --needed --noconfirm "$2"
    fi
}

installDependencies() {
    installIfRequired curl curl
    installIfRequired wimextract wimlib
    installIfRequired 7z p7zip
}

extractIso() {
    mkdir -p iso
    7z x "win${1}.iso" -oiso sources/install.wim
}

extractFromWim() {
    wimextract iso/sources/install.wim 1 "$1" --dest-dir fonts
}

preparePackage() {
    mkdir -p fonts
    curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ttf-ms-win${1}" > fonts/PKGBUILD
    extractFromWim "/Windows/Fonts/*.ttf"
    extractFromWim "/Windows/Fonts/*.ttc"
    extractFromWim "/Windows/System32/Licenses/neutral/*/*/license.rtf"
}

buildPackages() {
    cd fonts
    makepkg --skipchecksums .
    cd ..
}

cleanup() {
    mv "fonts/ttf-ms-win${1}-"*.pkg.tar.zst .
    rm -r fonts iso
}

install() {
    sudo pacman -U --noconfirm "ttf-ms-win${1}-"*.pkg.tar.zst
}

main() {
    checkIso "$1"
    installDependencies
    extractIso "$1"
    preparePackage "$1"
    buildPackages
    cleanup "$1"
    install "$1"
}

if [ "$#" -ne 1 ]; then
    echo "No version provided! Use 10 or 11."
    exit 1
fi

if [ "$1" -ne 10 ] && [ "$1" -ne 11 ]; then
    echo "Invalid version provided! Use 10 or 11."
    exit 1
fi

main "$1"
