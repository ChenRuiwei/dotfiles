#!/bin/bash

loaded_wallpapers="$(hyprctl hyprpaper listloaded)"
selected_wallpaper="$(echo "$loaded_wallpapers" | rofi -dmenu)"

hyprctl hyprpaper wallpaper ,"$selected_wallpaper"
wpg -a "$selected_wallpaper" && wpg -A "$selected_wallpaper" && wpg -s "$selected_wallpaper"
