#!/bin/sh

aur sync $(cat aur-packages.txt)
sudo pacman -S --needed $(cat aur-packages.txt) $(cat packages.txt)
