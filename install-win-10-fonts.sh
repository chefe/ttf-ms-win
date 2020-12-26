#!/bin/sh

checkIso() {
    foundIso=$(ls Win10*.iso 2> /dev/null | wc -l)
    if [ "$foundIso" -ne "1" ]; then
        link="https://www.microsoft.com/en-us/software-download/windows10ISO"

        echo "Windows 10 ISO not found, please download one from the following link:"
        echo "$link"

        xdg-open "$link"
        exit 1
    fi
}

installIfRequired() {
    which $1 > /dev/null 2>&1
    if [ "$?" -ne "0" ]; then
        sudo pacman -S --needed --noconfirm $2
    fi
}

installDependencies() {
    installIfRequired curl curl
    installIfRequired wimextract wimlib
    installIfRequired 7z p7zip
}

extractIso() {
    mkdir -p iso
    7z x Win10*.iso -oiso sources/install.wim
}

extractFromWim() {
    wimextract iso/sources/install.wim 1 "$1" --dest-dir fonts
}

preparePackage() {
    mkdir -p fonts
    curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ttf-ms-win10" > fonts/PKGBUILD
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
    mv fonts/ttf-ms-win10-*.pkg.tar.zst .
    rm -r fonts iso
}

install() {
    yay -U --noconfirm ttf-ms-win10-*.pkg.tar.zst
}

main() {
    checkIso
    installDependencies
    extractIso
    preparePackage
    buildPackages
    cleanup
    install
}

main
