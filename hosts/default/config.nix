{ config, pkgs, host, username, options, lib, inputs, system, ... }:
let inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ./modules/default.nix
    ../../modules/default.nix
  ];
  # Other configurations that don't fit into a module
  drivers = {
    amdgpu.enable = true;
    intel.enable = true;
    nvidia.enable = false;
    nvidia-prime = {
      enable = false;
      intelBusID = "";
      nvidiaBusID = "";
    };
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;
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
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
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
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };
  services.pulseaudio.enable = false;
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
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };
  hardware.graphics = { enable = true; };
  console.keyMap = "${keyboardLayout}";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.QML_IMPORT_PATH =
    "${pkgs.hyprland-qt-support}/lib/qt-6/qml";
  system.stateVersion = "24.11";
}
