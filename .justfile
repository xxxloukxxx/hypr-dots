set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

@default: testing install-pkg sync-cfg fonts

@testing:
    @# Moving to testing
    sudo rm -fr /etc/apt/sources.list
    sudo rsync -aq etc/apt/ /etc/apt/
    sudo apt-get -y -q=5 update
    sudo apt-get -y -q=5 full-upgrade --autoremove

@install-pkg:
    @# Install hyprland and friends ...
    sudo apt-get -y -q=5 install rsync wget curl
    sudo apt-get -y -q=5 install vim vim-gtk3 make p7zip-full nnn gcc build-essential locales-all fzf tmux silversearcher-ag rsync just zsh zsh-syntax-highlighting zsh-autosuggestions
    sudo apt-get -y -q=5 install firefox-esr firefox-esr-l10n-fr qimgv greetd "fonts-hack*" fonts-agave pulseaudio-utils trash-cli pulseaudio pavucontrol rofi greetd p7zip-full foot clang clangd "hypr*" waybar npm dusnt
    sudo apt-get -y -q=5 install zsh zsh-syntax-highlighting zsh-autosuggestions
    sudo chsh -s /usr/bin/zsh cedric

@sync-cfg:
    @# Sync config files
    rsync -aq .config/ ~/.config/
    rsync -aq .vimrc ~/
    rsync -aq .zshrc ~/
    rsync -aq .gitconfig ~/
    sudo rsync -aq etc/greetd/ /etc/greetd/

@fonts:
    @# Install fonts
    sudo apt-get -y -q=5 install p7zip-full
    7z x -y -bb0 .fonts.7z > /dev/null
    rsync -aq .fonts ~/
    rm -fr .fonts
    fc-cache -r

@push:
    @# Push to github
    git add .
    git commit -m "$(date)"
    git push

# vim: ft=just:ts=2:sw=4:
