#!/usr/bin/env bash

wallpaper_path=$HOME/Pictures/wallpapers
wallpapers_folder=$HOME/Pictures/wallpapers/others
wallpaper_name="$(ls -A $wallpapers_folder | rofi -dmenu -p "WallPaper" -i)"
if [[ -f $wallpapers_folder/$wallpaper_name ]]; then
    find ~/Pictures/wallpapers -maxdepth 1 -type f -delete
    ln -s $wallpapers_folder/$wallpaper_name $wallpaper_path/$wallpaper_name
    wall-change $wallpaper_path/$wallpaper_name
else
    exit 1
fi
