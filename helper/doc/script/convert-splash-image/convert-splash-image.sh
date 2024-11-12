#!/usr/bin/env bash




##
## create splash image
##

convert '/usr/share/desktop-base/active-theme/wallpaper/contents/images/1920x1080.svg' '1920x1080.jpg'

convert '/usr/share/desktop-base/active-theme/wallpaper/contents/images/1920x1080.svg' 'PNG32:1920x1080.png'

convert -resize '800x600' '/usr/share/desktop-base/active-theme/wallpaper/contents/images/1920x1080.svg' 'PNG32:800x600.png'

convert -resize '640x480' '/usr/share/desktop-base/active-theme/wallpaper/contents/images/1920x1080.svg' 'PNG32:640x480.png'
