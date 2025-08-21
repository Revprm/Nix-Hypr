# ./flake.nix
{
  description = "Rev's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    packet-tracer-binaries = {
      url = "path:/home/rev/MyOSConfigs/binaries";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, packet-tracer-binaries, ... }:
    let
      system = "x86_64-linux";
      host = "prm";
      username = "rev";
    in {
      overlays.default = import ./overlays;

      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit system inputs username host packet-tracer-binaries;
          };
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = self.overlays.default;
            })

            ./hosts/${host}/config.nix
            inputs.distro-grub-themes.nixosModules.${system}.default
            ./modules/hyprland/quickshell.nix
          ];
        };
      };
    };
}
