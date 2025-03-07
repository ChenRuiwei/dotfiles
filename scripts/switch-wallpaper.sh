#!/bin/bash

loaded_wallpapers="$(hyprctl hyprpaper listloaded)"
selected_wallpaper="$(echo "$loaded_wallpapers" | rofi -dmenu)"

hyprctl hyprpaper wallpaper ,"$selected_wallpaper"
wal -i "$selected_wallpaper"
