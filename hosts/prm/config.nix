{ config, pkgs, host, username, options, lib, inputs, system, ... }:
let inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ./modules/power-management.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/system-services.nix
    ./modules/security.nix
    ./modules/virtualization.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
  ];
  drivers = {
    amdgpu.enable = false;
    intel.enable = true;
    nvidia.enable = true;
    nvidia-prime = {
      enable = true;
      intelBusID = "PCI:0:2:0"; # Set your Intel Bus ID here
      nvidiaBusID = "PCI:1:0:0"; # Set your Nvidia Bus ID here
    };
  };
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };
  hardware = {
    logitech.wireless.enable = false;
    logitech.wireless.enableGraphical = false;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  hardware.graphics = { enable = true; };
  console.keyMap = "${keyboardLayout}";
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QML_IMPORT_PATH = "${pkgs.hyprland-qt-support}/lib/qt-6/qml";
  };
  system.stateVersion = "24.11";
}
