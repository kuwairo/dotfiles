if status is-interactive
    set -g fish_greeting
    set -g fish_term24bit 1

    set -g fish_pager_color_prefix
    set -g fish_pager_color_description

    # Sway
    test (tty) = "/dev/tty1" && exec launch
end
