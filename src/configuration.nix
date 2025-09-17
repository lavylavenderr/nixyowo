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

    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;
    
    home-manager.users."${config.var.username}" = import ./home.nix;
    time.hardwareClockInLocalTime = true;
    environment.systemPackages = with pkgs; [
      mangohud 
      protonup-qt 
      lutris 
      bottles 
      heroic
    ];  

    # The Earth will blow up if i touch this
    system.stateVersion = "24.05";
}
