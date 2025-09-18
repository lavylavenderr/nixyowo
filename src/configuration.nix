{config, pkgs, ...}: {
    imports = [
      ./system/audio.nix
      ./system/bluetooth.nix
      ./system/docker.nix
      ./system/home-manager.nix
      ./system/nix.nix
      ./system/nvidia.nix
      ./system/users.nix
      ./system/utils.nix

      ./variables.nix
      ./hardware-configuration.nix # MUST BE IN HERE WHENEVER I DO INSTALL :P
    ];

    # Boot Config & Home Manager 

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

    home-manager.users."${config.var.username}" = import ./home.nix;
    time.hardwareClockInLocalTime = true;

    # Profile Pictures for GDM

    system.activationScripts.script.text = ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp /home/lavender/face.png /var/lib/AccountsService/icons/lavender
      echo -e "[User]\nIcon=/var/lib/AccountsService/icons/lavender\n" > /var/lib/AccountsService/users/lavender
    '';

    # The Earth will blow up if i touch this
    
    system.stateVersion = "24.05";
}
