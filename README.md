# Niri dotfiles

Ensure that you have niri, fuzzel and either foot or alacritty terminals. Note that change-wallpaper script
utilized foot's ability to display pictures that lacks in alacritty.
```bash
pacman -S \
niri \
foot \
fuzzel \
waybar \
xdg-dbus-proxy \
wlsunset \
gpu-screen-recorder \
mako \
swaybg \
swayidle \
swaylock \
swayosd \
chafa \
imagemagick \
jq \
stow
```

```sh
cd dotfiles
stow niri
stow mako
stow waybar
stow swaylock
stow fuzzel
stow foot
stow alacritty
stow gtk-3.0
stow gtk-4.0
```

I haven't tested it, so it may be incorrect. *execute at your own risk*

## Background
`change-background` scripts @ dotfiles/bin searches for wallpapers in ~/Pictures/Wallpapers directory and creates directory with blurred
version for swaylock backround in this subfolder:
```sh
mkdir -p ~/Pictures/Wallpapers/Blurred
```
You can symlink your wallpaper to be shown with swaybg:
```sh
ln -sf ~/Pictures/Wallpapers/your_wallpaper.png ~/.config/wallpaper
```
And you can manually symlink your wallpaper for background in swaylock screen:
```sh
ln -sf ~/Pictures/Wallpapers/Blurred/your_blurred_wp.png ~/.config/wallpaper_blurred
```

## Services

#### Systemd
Source: https://niri-wm.github.io/niri/Example-systemd-Setup.html
```service
// ~/.config/systemd/user/swaybg.service
[Unit]
PartOf=graphical-session.target
After=graphical-session.target
Requisite=graphical-session.target

[Service]
ExecStart=/usr/bin/swaybg -m fill -i ${HOME}/.config/wallpaper
Restart=on-failure
```
```sh
```
```service
// ~/.config/systemd/user/swayidle.service
[Unit]
PartOf=graphical-session.target
After=graphical-session.target
Requisite=graphical-session.target

[Service]
ExecStart=/usr/bin/swayidle -w timeout 601 'niri msg action power-off-monitors' timeout 600 'swaylock -f' before-sleep 'swaylock -f'
Restart=on-failure
```
```sh
systemctl --user add-wants niri.service swayidle.service
systemctl --user add-wants niri.service mako.service
systemctl --user add-wants niri.service waybar.service
systemctl --user add-wants niri.service swaybg.service
```

