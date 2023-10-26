#!/bin/sh

export XDG_RUNTIME_DIR="/var/run/user/1001"
export XDG_CURRENT_DESKTOP="sway"
export QT_QPA_PLATFORM="wayland"
export GDK_BACKEND="wayland"
export MOZ_ENABLE_WAYLAND="1"

sway -c ~/.config/sway/config
