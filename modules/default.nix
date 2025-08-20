{ config, pkgs, lib, ... }:

{
  imports = [
    ./drivers/amd-drivers.nix
    ./drivers/nvidia-drivers.nix
    ./drivers/intel-drivers.nix
    ./drivers/nvidia-prime-drivers.nix
    ./hyprland/quickshell.nix
    ./services/local-hardware-clock.nix
    ./services/vm-guest-services.nix
  ];
}
