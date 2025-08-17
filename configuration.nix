# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs,  ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };
  services.tlp.enable = true;
  programs.command-not-found.enable = true;
  catppuccin.flavor = "macchiato";
  catppuccin.enable = true;
  systemd.user.timers.battery-reminder = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1m";
      Unit = "battery-reminder.service";
    };
  };

  systemd.user.services.battery-reminder = {
    script = ''
    #!/bin/bash

if [ "$(cat /sys/class/power_supply/BAT0/capacity)" -le 15 ] && [ "$(cat /sys/class/power_supply/BAT0/status)" == "Discharging" ]; then
	timeout 10 /run/current-system/sw/bin/qs -p /home/trinity/.config/quickshell/redbat/shell.qml
fi
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };
  programs.nh = {
	  enable = true;
	  clean.enable = true;
	  clean.extraArgs = "--keep-since 4d --keep 3";
	  flake = "/etc/nixos";
  };
  programs.noisetorch.enable = true;
  xdg.portal.config = {
  common = {
    default = [
      "hyprland"
    ];
  };
  };
  services.upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 10;
      criticalPowerAction = "HybridSleep";
    };
  services.printing.drivers = [ pkgs.hplip ];
  services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
  };
  services.printing.enable = true;
  services.tailscale.enable = true;
  networking.firewall.checkReversePath = false; 

  fonts.fontconfig.enable = true;
  fonts.fontconfig.hinting.enable = true;
  fonts.packages = with pkgs; [ 
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  services.logind.lidSwitch = "suspend";
  environment.variables = {
  GTK_THEME = "Adwaita:dark";
  BROWSER = "zen";
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.trinity = {
     isNormalUser = true;
     extraGroups = [ "wheel" "input" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

   programs.firefox.enable = true;
   programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages =  [
     pkgs.lm_sensors
     pkgs.adoptopenjdk-icedtea-web
     pkgs.adw-gtk3
     pkgs.blueman
     pkgs.btop
     pkgs.bun
     pkgs.cmake
     pkgs.eog
     pkgs.gnumake
     pkgs.gutenprint
     pkgs.hunspell
     pkgs.libnotify
     pkgs.libreoffice-qt
     pkgs.luarocks
     pkgs.mediastreamer-openh264
     pkgs.microfetch
     pkgs.mpv
     pkgs.gh
     pkgs.nautilus
     pkgs.nodejs_22
     pkgs.pavucontrol
     pkgs.pnpm
     pkgs.rustc
     pkgs.rustup
     pkgs.traceroute
     pkgs.vesktop
     pkgs.walker
     pkgs.wl-clipboard
     pkgs.xwayland
     pkgs.xdg-utils
     pkgs.vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     pkgs.wget
     pkgs.fastfetch
     pkgs.starship
     pkgs.prismlauncher
     pkgs.ffmpeg
     pkgs.kitty
     inputs.zen-browser.packages.x86_64-linux.default # beta
     pkgs.adwaita-icon-theme
     pkgs.jetbrains-mono
     pkgs.bibata-cursors
     pkgs.brightnessctl
     pkgs.kdePackages.dolphin
     pkgs.fd
     pkgs.gcc
     pkgs.git
     pkgs.glib
     pkgs.grim
     pkgs.tlp
     pkgs.hyprcursor
     pkgs.libinput-gestures
     pkgs.libinput
     pkgs.wmctrl
     pkgs.ydotool
     pkgs.xdotool
     inputs.quickshell.packages.x86_64-linux.default
     pkgs.hyprpaper
     pkgs.lazygit
     pkgs.neovim
     pkgs.playerctl
     pkgs.ripgrep
     pkgs.slurp
     pkgs.swappy
     pkgs.upower
     pkgs.wofi
];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.fish.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}
