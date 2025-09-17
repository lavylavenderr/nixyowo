{
  pkgs,
  inputs,
  config,
  ...
}: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
    themeConfig = {
      Background = pkgs.fetchurl {
        url = "https://i.imgur.com/8mExMzT.png";
        sha256 = "sha256-Xra+aqGAwV/6cM41ZK5kIqRLV4+cZJGKipTacxr/kEM=";
      };
    };
  };
in {
  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      extraPackages = [sddm-astronaut];
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut";
      settings = {
        Wayland.SessionDir = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
      };
    };
  };
}
