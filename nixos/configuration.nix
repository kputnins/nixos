# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # For amd PRO
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
  hardware.opengl.driSupport = true; # This is already enabled by default
  hardware.opengl.driSupport32Bit = true; # For 32 bit applications

  networking.hostName = "KP-NIXOS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Riga";

  location = {
    # Riga City
    latitude = 56.9677;
    longitude = 24.1056;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "lv_LV.UTF-8";
    LC_IDENTIFICATION = "lv_LV.UTF-8";
    LC_MEASUREMENT = "lv_LV.UTF-8";
    LC_MONETARY = "lv_LV.UTF-8";
    LC_NAME = "lv_LV.UTF-8";
    LC_NUMERIC = "lv_LV.UTF-8";
    LC_PAPER = "lv_LV.UTF-8";
    LC_TELEPHONE = "lv_LV.UTF-8";
    LC_TIME = "lv_LV.UTF-8";
  };

  # Fonts
  fonts.packages = with pkgs; [
    # Use 'FiraMono Nerd Font' in terminals for icon symbol support
     (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "lv";
    variant = "apostrophe";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enables bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kp = {
    isNormalUser = true;
    description = "Kaspars Putniņš";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # user specific apckages
    ];
  };
  users.users.liene = {
    isNormalUser = true;
    description = "Liene Putniņa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # user specific apckages
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  # Home manager
  home-manager = {
  	extraSpecialArgs = { inherit inputs; };
  	users = {
  	  "kp" = import ./home.nix;
  	};
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.extension-list
    gnomeExtensions.lock-keys
    gnomeExtensions.solaar-extension
    gnomeExtensions.undecorate
    gnomeExtensions.vitals
    gnomeExtensions.native-window-placement
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.workspace-indicator
    gnomeExtensions.tactile
    nano
    micro
    clinfo
    eza
    bat
    btop
    fd
    fzf
    zsh
    direnv
    git
    solaar
    nodejs
    vscodium
    steam
    lutris
    firefox
    google-chrome
    discord
    vlc
    smplayer
    flameshot
    deluge
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.zsh.enable = true;

  # LD fix
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # To get zsh tcompletion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  # List services that you want to enable:
  services = {
    gnome.gnome-keyring.enable = true;

    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    redshift = {
      enable = true;
      temperature = {
        # orange = 1000, white = 5000
        day = 5000;
        night = 2300;
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}