{ pkgs, ... }:

{
  developer-packages = with pkgs; [
    # Core Development Tools
    vscode
    gcc
    gnumake
    tree
    htop
    obs-studio
    postman
    spicetify-cli
    texliveFull

    # NodeJS Ecosystem
    nodejs
    nodePackages.npm
    nodePackages.yarn
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Python Development
    python3
    python3Packages.pip
    python3Packages.virtualenv

    # Rust Development
    rustc
    cargo

    # PHP Development
    php
    php83Packages.composer
    php83Packages.psalm

    # Go Development
    go
    gopls
    delve
  ];
}
