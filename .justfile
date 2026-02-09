set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

@default: testing install-pkg sync-cfg fonts

@testing:
    @# Moving to testing
    sudo rm -fr /etc/apt/sources.list
    sudo rsync -aq etc/apt/ /etc/apt/
    sudo apt -y -qq update
    sudo DEBIAN_FRONTEND=noninteractive apt -y -qq --autoremove full-upgrade

@install-pkg:
    @# Install hyprland and friends ...
    sudo apt -y -qq install rsync wget curl
    sudo apt -y -qq install vim vim-gtk3 make p7zip-full nnn gcc build-essential locales-all fzf tmux silversearcher-ag rsync just zsh zsh-syntax-highlighting zsh-autosuggestions
    sudo apt -y -qq install firefox-esr firefox-esr-l10n-fr qimgv greetd "fonts-hack*" fonts-agave pulseaudio-utils trash-cli pulseaudio pavucontrol fuzzel greetd p7zip-full foot clang clangd "hypr*" waybar npm dunst pipewire xdg-desktop-portal-hyprland qtwayland5 "qt6-wayland*"
    sudo apt -y -qq install zsh zsh-syntax-highlighting zsh-autosuggestions
    sudo chsh -s /usr/bin/zsh cedric

@sync-cfg:
    @# Sync config files
    rsync -aq .config/ ~/.config/
    rsync -aq .vimrc ~/
    rsync -aq .zshrc ~/
    rsync -aq .gitconfig ~/
    rsync -aq .XCompose ~/
    sudo rsync -aq etc/greetd/ /etc/greetd/
    sudo rsync -aq .bin/ /usr/local/bin/

@fonts:
    @# Install fonts
    sudo apt -y -qq install p7zip-full
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
