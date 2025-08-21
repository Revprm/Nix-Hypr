# Personal NixOS Hyprland Config

This repository contains my personal NixOS configuration, centered around the Hyprland Wayland compositor. It's built on a modular flake structure for easy management and customization.

## ✨ Features

This setup is designed for both development and gaming, with a sleek, minimalist aesthetic. Key features include:

  * **Compositor**: **Hyprland** with dynamic animations and extensive customization options.
  * **Status Bar**: **Waybar** with multiple layouts and styles, including a Catppuccin theme.
  * **Application Launcher**: **Rofi** for quick application launching and various utility scripts (clipboard, emojis, etc.).
  * **Terminal**: **Kitty** with a wide selection of themes.
  * **Notifications**: **SwayNC** for a clean, unified notification system.
  * **Theming**: **Catppuccin** color schemes applied consistently across applications (Waybar, Rofi, Kitty, GTK, QT).
  * **File Manager**: **Thunar** pre-configured for a smooth experience.
  * **Development**: Pre-installed support for major programming languages like **Node.js, Python, Rust, Go, PHP, and C/C++**.
  * **Gaming**: Essential gaming platforms like **Steam, Lutris, and Heroic Games Launcher** are included.
  * **Hardware Support**: Comprehensive drivers for **AMD, Intel, and NVIDIA** GPUs, including NVIDIA Prime.
  * **Utilities**: A suite of helpful scripts for managing power profiles, Waybar layouts, wallpapers, and more.

## 🚀 Quick Install

The easiest way to get started is by using the automated installer.

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Revprm/Nix-Hypr.git ~/Nix-Hypr
    cd ~/Nix-Hypr
    ```

2.  **Run the installer script:**

    ```bash
    ./install.sh
    ```

The installer will prompt you for your hostname and keyboard layout. Once it completes, you will be asked to reboot your system.

## ⚙️ Configuration & Customization

This setup uses a flake-based, modular structure. All configuration files are located in the `hosts` directory, with sub-directories for each hostname.

### User Variables

For common settings like your Git user, email, default browser, and keyboard layout, edit the `variables.nix` file:

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

To add new packages, you can edit the `users.nix` file for a per-user installation or the `config.nix` file for a system-wide installation. For a more organized approach, you can create new `.nix` files within the `packages` directory and import them into `users.nix`.

For example, to add `htop` for your user, add it to `packakges` folder:

```nix
# hosts/<hostname>/packages/<package-name>.nix
...
package-name = with pkgs; [
    # Add your packages here
    htop
];
```

### Theming and Dotfiles

Customization of applications like Waybar, Rofi, Kitty, and others is handled through the `dotfiles` directory. The structure is simple: each application has its own subdirectory containing its configuration files. This makes it easy to modify specific settings or add new themes.

For example, you can find a variety of Waybar and Rofi themes in:

  * `dotfiles/waybar/configs/`
  * `dotfiles/waybar/style/`
  * `dotfiles/rofi/themes/`

Feel free to browse and modify these files to match your style.

## 🔄 Updating Your System

To keep your NixOS system and this configuration up to date, simply run the update script from the repository's root directory:

```bash
./update.sh
```

This command will automatically fetch the latest changes and rebuild your system.