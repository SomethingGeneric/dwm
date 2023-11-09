#!/usr/bin/env bash

#set -e

me="matt"

multi="no"
[[ -f /home/$me/.multi ]] && multi="yes"

install_dwm() {
    pushd dwm
    sudo make install clean
    popd
}

install_slstatus() {
	if [[ -d slstatus ]]; then
		pushd slstatus && git pull && popd
	else
    	git clone https://github.com/SomethingGeneric/slstatus
	fi
    cp slstatus.config.h slstatus/config.h
    pushd slstatus
    sudo make install clean
    popd
    rm -rf slstatus
}

install_rofi_configs() {
    git clone --depth=1 https://github.com/adi1090x/rofi.git
	pushd rofi
	chmod +x setup.sh
	su $me -c "./setup.sh"
	sed -i "s/'style-1'/'style-4'/g" /home/$me/.config/rofi/launchers/type-6/launcher.sh
	popd
    rm -rf rofi
}

install_maim() {
    [[ -d slop ]] && rm -rf slop
    git clone https://github.com/naelstrof/slop.git
    cd slop
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="/usr" ./
    make && sudo make install
    cd ..
    git clone https://github.com/naelstrof/maim.git
    cd maim
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="/usr" ./
    make && sudo make install
    cd ..
    rm -rf {slop,maim}

    [[ ! -d /home/$me/.local/bin ]] && mkdir /home/$me/.local/bin
    cp screenshot.sh /home/$me/.local/bin/.
}

install_xinitrc() {
    cp xinitrc /home/$me/.xinitrc
    cp Xresources /home/$me/.Xresources
}

install_screenlayout() {
    if [[ ! -d /home/$me/.local/bin ]]; then
        mkdir -p /home/$me/.local/bin
    fi
    [[ "$multi" == "yes" ]] && cp displays.sh /home/$me/.local/bin/.
}

fix_perms() {
    sudo chown -R $me:$me *
}

ensure_packages() {
    if [[ "$(which sudo)" == "" ]]; then
        echo "Install sudo, please."
        exit 1
    fi

    if [[ -d /etc/pacman.d ]]; then
        mgr="pacman -S --needed --noconfirm"
    elif [[ -d /etc/apt ]]; then
        mgr="apt install -y"
    elif [[ -d /etc/slackpkg ]]; then
	    echo "W/ slackware, you should have everything except the following, which you can get from sbopkg (SlackBuilds.org)"
        echo "feh, wezterm, rofi, glm, xclip"
	    mgr="skip"
    elif  [[ -d /etc/portage ]]; then
        mgr="skip"
        sudo emerge x11-misc/xclip feh rofi arandr xorg-server xinit glm dev-vcs/git
        echo "on gentoo you have to unmask wezterm by the way"
    else
        echo "No idea what distro you're on. Open an issue."
        exit 1
    fi

    [[ ! "$mgr" == "skip" ]] && sudo ${mgr} feh wezterm rofi arandr xorg xorg-xinit glm xclip git cmake maim glm
    touch /home/$me/.suckless_pkgs
}

setup_wallpaper() {
    cp wallpaper.jpg /home/$me/.wallpaper.jpg
}

install_backlight() {
    [[ ! -d /home/$me/.local/bin ]] && mkdir /home/$me/.local/bin
	cp backlight.py /home/$me/.local/bin/.
	cp bl*.sh /home/$me/.local/bin/.
	echo "make sure that you have passwordless sudo for /home/$me/.local/bin/backlight.py"
}

############################################################

if [[ ! -f /home/$me/.suckless_pkgs ]]; then
    ensure_packages
fi

install_dwm
install_slstatus
install_rofi_configs
install_xinitrc
install_maim
install_backlight
install_screenlayout
setup_wallpaper
fix_perms
