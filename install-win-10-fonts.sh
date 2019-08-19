#!/bin/sh

checkIso() {
    foundIso=$(ls Win10*.iso 2> /dev/null | wc -l)
    if [ "$foundIso" -ne "1" ]; then
        link="https://www.microsoft.com/de-de/software-download/windows10ISO"

        echo "Windows iso can not be found, please download from the following link:"
        echo "$link"

        xdg-open "$link"
        exit 1
    fi
}

installDependencies() {
    wimextract --version > /dev/null 2>&1
    if [ "$1" -ne "0" ]; then
        yay -S --needed --noconfirm wimlib
    fi
}

extractIso() {
    mkdir -p iso
    7z x Win10*.iso -oiso sources/install.wim
}

preparePackage() {
	mkdir -p fonts
    curl https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ttf-ms-win10 > fonts/PKGBUILD
	bash -c 'wimextract iso/sources/install.wim 1 /Windows/{Fonts/"*".{ttf,ttc},System32/Licenses/neutral/"*"/"*"/license.rtf} --dest-dir fonts'
}

buildPackages() {
    cd fonts
    makepkg --skipchecksums .
    cd ..
}

cleanup() {
    mv fonts/ttf-ms-win10-[0-9]* .
    rm -r fonts iso
}

install() {
    yay -U --noconfirm ttf-ms-win10-*.pkg.tar.xz
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
