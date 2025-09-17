{
  description = ''
    this is ma nix configuration that i'm trying >:3
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {nixpkgs, ...}: {
    nixosConfigurations = {
      nixyowo =
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs.overlays = [];
              _module.args = {
                inherit inputs;
              };
            }
            inputs.home-manager.nixosModules.home-manager
            impermanence.homeManagerModules.impermanence
            ./src/configuration.nix
          ];
        };
    };
  };
}
