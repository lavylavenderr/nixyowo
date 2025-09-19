{
    pkgs,
    config,
    inputs,
    ...
}: let
  hostname = config.var.hostname;
  keyboardLayout = config.var.keyboardLayout;
  configDir = config.var.configDirectory;
  timeZone = config.var.timeZone;
  defaultLocale = config.var.defaultLocale;
  autoUpgrade = config.var.autoUpgrade;
in {
  networking.hostName = hostname;

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  system.autoUpgrade = {
    enable = autoUpgrade;
    dates = "04:00";
    flake = "${configDir}";
    flags = ["--update-input" "nixpkgs" "--commit-lock-file"];
    allowReboot = false;
  };

  time = {timeZone = timeZone;};
  i18n.defaultLocale = defaultLocale;
  console.keyMap = keyboardLayout;

  programs = {
    nix-ld.enable = true;
    obs-studio = {
      enable = true;
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      platformOptimizations.enable = true;
    };
    gamemode.enable = true;
    dconf.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "lavender" ];
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        nixrebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      };
    };
    ohMyZsh = {
      enable = true;
      plugins = ["git" "fzf" "kitty" "systemd" "qrcode" "docker"];
      theme = "lambda"; 

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
  
  services = {
    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [ gcr ];
    };
    flatpak.enable = true;
    gvfs.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
    libinput.enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      sddm = {
        extraPackages = [sddm-astronaut];
        enable = false;
        wayland.enable = false;
        theme = "sddm-astronaut";
      };
    };
    xserver = {
      enable = true;
      xkb.layout = keyboardLayout;
      xkb.variant = "";
    };
    desktopManager.plasma6.enable = true;
  };


  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  environment.systemPackages = with pkgs; [
    fd
    bc
    gcc
    git-ignore
    xdg-utils
    wget
    curl
    vim
    go
    comma
    mangohud 
    protonup-qt 
    lutris 
    bottles 
    heroic
    _1password-gui
    _1password-cli
    libGL
    htop
    libGLU
    steam-run
    protonup-qt
    krita
    flameshot
    xclip
    libreoffice-fresh
    gparted
    inputs.nix-gaming.packages.${pkgs.system}.winetricks-git
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg
    inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    simplescreenrecorder
  ];

  security = {
    sudo.wheelNeedsPassword = false;
  };
}
