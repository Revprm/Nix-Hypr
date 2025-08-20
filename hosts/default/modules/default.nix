{ config, pkgs, lib, ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./security.nix
    ./system-services.nix
  ];
}
