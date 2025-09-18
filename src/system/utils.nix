{
    pkgs,
    config,
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
    };
    gamemode.enable = true;
    dconf.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "lavender" ];
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
    libGLU
    steam-run
  ];

  security = {
    sudo.wheelNeedsPassword = false;
  };
}
