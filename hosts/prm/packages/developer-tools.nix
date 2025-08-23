{ pkgs, ... }:
let
  myPythonEnv = pkgs.python3.withPackages (python-pkgs:
    with python-pkgs; [
      pwntools # Example of a package, add more here
      virtualenv
      pip
      pycryptodome
      numpy
      pandas
      matplotlib
      scikit-learn
      flask
      pillow
      pyinstaller
      scapy
    ]);
in {
  developer-packages = with pkgs; [
    # Core Development Tools
    vscode
    code-cursor
    gcc
    gnumake
    tree
    htop
    obs-studio
    postman
    texliveFull
    p7zip
    openssl
    pkg-config
    cdrtools

    # NodeJS Ecosystem
    nodejs
    nodePackages.npm
    nodePackages.yarn
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Python Development
    myPythonEnv

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

    # Documents
    libreoffice
    obsidian
    pandoc
    typst
    wpsoffice
    # Add Database if Needed (me personally uses docker for databases)
  ];
}
