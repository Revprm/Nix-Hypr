{ pkgs, username, inputs, ... }:
let
  inherit (import ./variables.nix) gitUsername;
  # Import package modules
  allPackages = import ./packages/default.nix { inherit pkgs inputs; };
in {
  imports = [ ./modules/zsh.nix ];
  nixpkgs.config.permittedInsecurePackages = [ "libxml2-2.13.8" ];
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "docker"
      ];
      # Modularized user packages
      packages = allPackages.all-packages;
    };
    defaultUserShell = pkgs.zsh;
  };
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ lsd fzf ];
  security.wrappers.ubridge = {
    source = "${pkgs.ubridge}/bin/ubridge";
    owner = "root";
    group = "root";
    capabilities = "cap_net_admin,cap_net_raw+ep";
  };
}
