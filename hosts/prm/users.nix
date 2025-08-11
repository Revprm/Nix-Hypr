{ pkgs, username, ... }:

let
  inherit (import ./variables.nix) gitUsername;

  # Import package modules
  developer = import ./packages/developer-tools.nix { inherit pkgs; };
  security = import ./packages/security-tools.nix { inherit pkgs; };
  entertainment = import ./packages/entertainment.nix { inherit pkgs; };
  social = import ./packages/social.nix { inherit pkgs; };
  games = import ./packages/games.nix { inherit pkgs; };

in {
  imports = [ ./modules/zsh.nix ];
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
      packages = developer.developer-packages ++ security.security-packages
        ++ entertainment.entertainment-packages ++ social.social-packages
        ++ games.games-packages;
    };

    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ lsd fzf ];

}
