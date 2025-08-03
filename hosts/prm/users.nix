# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

let inherit (import ./variables.nix) gitUsername;
in {
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
      ];

      # define user packages here
      packages = with pkgs; [
        # Developer Tools
        vscode
        gcc
        gnumake
        docker
        docker-compose
        tree
        htop
        obs-studio
        postman
        spicetify-cli

        # NodeJS
        nodejs
        nodePackages.npm
        nodePackages.yarn
        nodePackages.typescript
        nodePackages.typescript-language-server

        # Python
        python3
        python3Packages.pip
        python3Packages.virtualenv

        # Rust
        rustc
        cargo

        # PHP
        php
        php83Packages.composer
        php83Packages.psalm

        # Golang
        go
        gopls
        delve

        # Cysec Stuffs
        wireshark
        exiftool
        file
        nmap
        binwalk
        john
        hashcat
        foremost
        steghide
        stegseek
        zsteg
        gdb
        ghidra-bin
        cutter
        yara

        # Animanga
        ani-cli
        manga-tui

        # Social
        zapzap
      ];
    };

    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ lsd fzf ];

  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      promptInit = ''
        fastfetch -c $HOME/.config/fastfetch/config.jsonc

        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 

        # Set-up icons for files/directories in terminal using lsd
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
      '';
    };
  };
}
