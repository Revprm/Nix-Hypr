# Personal NixOS Hyprland Config

This repository contains my personal NixOS configuration, which is based on the Hyprland Wayland compositor. It uses a modular flake structure for easy management.

## ✨ Features

This setup is designed for both development and gaming.

  * **Compositor**: Hyprland
  * **Status Bar**: Waybar
  * **Application Launcher**: Rofi
  * **Terminal**: Kitty
  * **Notifications**: SwayNC
  * **Theming**: Catppuccin color schemes for most applications.
  * **File Manager**: Thunar
  * **Development**: Support for Node.js, Python, Rust, Go, PHP, and C/C++.
  * **Gaming**: Includes Steam, Lutris, and Heroic Games Launcher.
  * **Hardware Support**: Drivers for AMD, Intel, and NVIDIA GPUs.

## 🚀 Quick Install

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Revprm/Nix-Hypr.git ~/Nix-Hypr
    cd ~/Nix-Hypr
    ```

2.  **Run the installer script:**

    ```bash
    ./install.sh
    ```

    The installer will ask for your hostname and keyboard layout, and then prompt you to reboot.

## ⚙️ Configuration & Customization

The configuration is modular and uses a flake-based structure. All configuration files are in the `hosts` directory.

### User Variables

Edit `variables.nix` to change common settings like your Git username, email, default browser, and keyboard layout.

```nix
# hosts/<hostname>/variables.nix
{
  gitUsername = "YourName";
  gitEmail = "your@email.com";
  browser = "firefox";
  terminal = "kitty";
  keyboardLayout = "us";
}
```

### Adding Packages

To add new packages, edit the `users.nix` file for per-user installation or the `config.nix` file for a system-wide installation. For a more organized approach, you can create new `.nix` files in the `packages` directory and import them into `users.nix`.

For example, to add `htop`, add it to the `packages` folder:

```nix
# hosts/<hostname>/packages/<package-name>.nix
...
package-name = with pkgs; [
    # Add your packages here
    htop
];
```

### Theming and Dotfiles

Application customization (e.g., Waybar, Rofi, Kitty) is handled through the `dotfiles` directory. Each application has its own subdirectory with configuration files. You can find themes for Waybar and Rofi in:

  * `dotfiles/waybar/configs/`
  * `dotfiles/waybar/style/`
  * `dotfiles/rofi/themes/`

## 🔄 Updating Your System

To update your NixOS system and this configuration, run the update script from the repository's root directory:

```bash
./update.sh
```

> [\!IMPORTANT]
> This command will also update your `flake.lock` file. Make sure to have a backup of your configuration to roll back if issues occur.
