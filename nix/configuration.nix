{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    mirroredBoots = [
      {
        path = "/boot";
        devices = [ "nodev" ];
      }
      {
        path = "/boot-fallback";
        devices = [ "nodev" ];
      }
    ];
  };

  boot.zfs.devNodes = "/dev/disk/by-id";
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "zroot/os";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "zroot/nix";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "zroot/home";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2710-238A";
    fsType = "vfat";
    options = [ "nofail" ];
  };

  fileSystems."/boot-fallback" = {
    device = "/dev/disk/by-uuid/2778-3DBA";
    fsType = "vfat";
    options = [ "nofail" ];
  };

  networking = {
    hostId = "2b4bc599";
    hostName = "solljus";
    networkmanager.enable = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Krasnoyarsk";

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager = {
      gdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "regn";
    };
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  # GDM automatic login fix
  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.gnome.excludePackages = with pkgs; with pkgs.gnome; [
    cheese
    epiphany
    geary
    gnome-calendar
    gnome-contacts
    gnome-music
    gnome-photos
    gnome-tour
    totem
    yelp
  ];

  # Useful for virt-manager
  programs.dconf.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.regn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
  };

  environment.systemPackages = with pkgs; [
    blackbox-terminal
    btop
    celluloid
    curl
    firefox
    git
    gnome.gnome-tweaks
    libva-utils
    papirus-icon-theme
    transmission-gtk
    tree
    vim
    virt-manager
    vscode.fhs
    wget
    wl-clipboard
  ];

  fonts.fonts = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    roboto
    roboto-mono
  ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };

  virtualisation.libvirtd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

