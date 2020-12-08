# ttf-ms-win10
A script to install the [windows default fonts][1] on [archlinux][2]

## Preconditions
A Windows 10 ISO has to be downloaded manually before the script. See [link][3].

## Usage
```
$ ./install-win-10-fonts.sh
```

## Dependencies
* [7z][4]
* [wimextract][5]
* [curl][6]

All dependencies will be automatically installed by the script if needed

# Credits
The install script is based on the [ttf-ms-win10][7] aur package. 


[1]: https://docs.microsoft.com/typography/fonts/windows_10_font_list
[2]: https://archlinux.org
[3]: https://www.microsoft.com/de-de/software-download/windows10ISO
[4]: https://www.archlinux.org/packages/extra/x86_64/p7zip/
[5]: https://www.archlinux.org/packages/community/x86_64/wimlib/
[6]: https://www.archlinux.org/packages/core/x86_64/curl/
[7]: https://aur.archlinux.org/packages/ttf-ms-win10/
