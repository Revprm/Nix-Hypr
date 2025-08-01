# Personal NixOS Hyprland Configuration

This is a personalized NixOS configuration for Hyprland, a dynamic tiling Wayland compositor. It is based on the work of JaKooLit.

## 🌟 Features

-   **Window Manager**: [Hyprland](https://hyprland.org/) with a customized setup.
-   **Bar**: Waybar for a sleek and informative status bar.
-   **Shell**: Zsh with Oh My Zsh for a powerful and customizable command-line experience.
-   **Login Manager**: Greetd with `tuigreet` for a fast and lightweight text-based login.
-   **Terminal**: Kitty is the default terminal emulator.
-   **Web Browser**: Firefox is the default browser.
-   **File Manager**: Thunar, with custom actions and settings.
-   **Fonts**: A curated collection of fonts including Fira Code, JetBrains Mono, and Nerd Fonts.
-   **Drivers**: Support for AMD, Intel, and NVIDIA graphics drivers.
-   **Software**: A comprehensive set of packages for development, gaming, and cybersecurity.

## 🚀 Installation

This configuration can be installed using one of the provided installation scripts:

-   `auto-install.sh`: Clones the repository and runs the installation script automatically.
-   `install.sh`: A script to be run from within the cloned repository.

Both scripts will guide you through the process, prompting for a **hostname** and **keyboard layout**. They will also automatically detect if you are running in a VM or have an NVIDIA GPU and adjust the configuration accordingly.

## 📂 Structure

The configuration is organized as follows:

```
├── flake.nix
├── hosts
│   ├── default
│   └── prm
├── modules
└── assets
```

-   `flake.nix`: The entry point for the NixOS configuration. It defines the system architecture, user, and host.
-   `hosts/`: Contains host-specific configurations. You can create a new directory for your machine by following the prompts in the installation script.
    -   `config.nix`: The main configuration file for the host.
    -   `packages-fonts.nix`: Defines system-wide packages and fonts.
    -   `users.nix`: User-specific settings and packages.
    -   `variables.nix`: A place to define variables like the default browser and terminal.
-   `modules/`: Contains modularized configurations for drivers, services, and other system components.
-   `assets/`: Includes configuration files for various applications like `fastfetch`, `thunar`, and `gtk`.

## 🛠️ Customization

You can easily customize this configuration by editing the files in `hosts/<your-hostname>/`. The `variables.nix` file is a good place to start for simple changes like your git configuration and default applications.

## 🙏 Credits

A big thank you to **JaKooLit** for the original configuration and scripts. You can find their GitHub profile [here](https://github.com/JaKooLit).
