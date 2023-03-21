# Suckless

dwm setup

## Versions:
- dwm: 6.4
- slstatus: latest git from a personal fork
- maim: latest from git repo
- slopy: latest from git repo
- Others: latest from system package manager

## Depends
Various programs are installed using the system's package manager. The script currently only auto-detects `pacman`, `apt`, and `slackpkg`

## Things to change:
* Look over `make.sh`
* `xinitrc`, since by default it gets copied to `~/`
