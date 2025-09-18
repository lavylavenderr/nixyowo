{config, pkgs, ...}: {
    imports = [
      ./system/audio.nix
      ./system/bluetooth.nix
      ./system/docker.nix
      ./system/home-manager.nix
      ./system/nix.nix
      ./system/nvidia.nix
      ./system/sddm.nix
      ./system/users.nix
      ./system/utils.nix

      ./variables.nix
      ./hardware-configuration.nix # MUST BE IN HERE WHENEVER I DO INSTALL :P
    ];

    # Boot Config

    boot.loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        devices = [ "nodev" ];
        efiSupport = true;
        enable = true;
        useOSProber = true;
      };
    };

    # Misc Config 

    services.flatpak.enable = true;

    programs.nix-ld.enable = true;
programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;

    services.displayManager.gdm.wayland = true;
    services.displayManager.gdm.enable = true;
    home-manager.users."${config.var.username}" = import ./home.nix;
    time.hardwareClockInLocalTime = true;

    environment.systemPackages = with pkgs; [
      mangohud 
      protonup-qt 
      lutris 
      bottles 
      heroic
      _1password-gui
      _1password-cli
      libGL
      libGLU
    ];  

    # Profile Pictures for GDM

    system.activationScripts.script.text = ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp /home/lavender/face.png /var/lib/AccountsService/icons/lavender
      echo -e "[User]\nIcon=/var/lib/AccountsService/icons/lavender\n" > /var/lib/AccountsService/users/lavender
    '';

    # 1Password

    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "lavender" ];
    };

    # The Earth will blow up if i touch this
    
    system.stateVersion = "24.05";
}
