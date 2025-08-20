{ config, pkgs, lib, ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./power-management.nix
    ./security.nix
    ./system-services.nix
    ./virtualization.nix
    ./zsh.nix
  ];
}
