# ttf-ms-win
A script to install the windows default fonts on [archlinux][1]

## Preconditions
A Windows ISO has to be downloaded manually before the script.

## Usage
```
# Install win 10 fonts
$ ./install-win-fonts.sh 10

# Install win 11 fonts
$ ./install-win-fonts.sh 11
```

## Dependencies
* [7z][2]
* [wimextract][3]
* [curl][4]

All dependencies will be automatically installed by the script if needed

# Credits
The install script is based on the [ttf-ms-win10][5] and 
[ttf-ms-win11][6] aur package. 


[1]: https://archlinux.org
[2]: https://www.archlinux.org/packages/extra/x86_64/p7zip/
[3]: https://www.archlinux.org/packages/community/x86_64/wimlib/
[4]: https://www.archlinux.org/packages/core/x86_64/curl/
[5]: https://aur.archlinux.org/packages/ttf-ms-win10/
[6]: https://aur.archlinux.org/packages/ttf-ms-win11/
