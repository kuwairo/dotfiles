function xbps-install
    set -l root (zfs mount | grep ' /$' | cut -d ' ' -f 1)

    sudo zfs snapshot "$root@xbps-install_$(date '+%F-%H%M%S')"
    and sudo (which xbps-install) $argv

    set -l keep 10
    set -l list (zfs list -o name -t snapshot | grep $root'@xbps-install_')
    for snapshot in $list[1..(math -1 - $keep)]
        sudo zfs destroy $snapshot
    end
end
