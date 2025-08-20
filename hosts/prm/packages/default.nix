{ pkgs, inputs, ... }:
let
  developer = import ./developer-tools.nix { inherit pkgs; };
  security = import ./security-tools.nix { inherit pkgs inputs; };
  entertainment = import ./entertainment.nix { inherit pkgs; };
  social = import ./social.nix { inherit pkgs; };
  games = import ./games.nix { inherit pkgs; };
in {
  # Export all package lists for easy access
  developer-packages = developer.developer-packages;
  security-packages = security.security-packages;
  entertainment-packages = entertainment.entertainment-packages;
  social-packages = social.social-packages;
  games-packages = games.games-packages;

  # Combined list of all packages
  all-packages = developer.developer-packages ++ security.security-packages
    ++ entertainment.entertainment-packages ++ social.social-packages
    ++ games.games-packages;
}
