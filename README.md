# Personal NixOS Hyprland Configuration

This is a highly customized NixOS configuration for Hyprland, a dynamic tiling Wayland compositor. Originally based on [JaKooLit's configuration](https://github.com/JaKooLit/NixOS-Hyprland), it has been extensively modified and personalized.

## 🌟 Features

### 🪟 Desktop Environment

-   **Window Manager**: [Hyprland](https://hyprland.org/) with custom animations, keybindings, and workspace management
-   **Status Bar**: Waybar with customizable modules and styling
-   **Shell Alternative**: QuickShell for advanced desktop shell functionality
-   **Application Launcher**: Rofi with multiple themes and configurations
-   **Lock Screen**: Hyprlock with custom styling
-   **Idle Management**: Hypridle for automatic screen locking
-   **Logout Menu**: Wlogout with custom styling

### 🎨 Theming & Aesthetics

-   **Theme Engine**: Wallust for dynamic color scheme generation
-   **Cursor Theme**: Bibata-Modern-Ice
-   **GTK Themes**: Custom configurations for GTK 3.0
-   **Qt Themes**: Kvantum support with Catppuccin themes
-   **Icons**: Custom icon configurations
-   **Wallpaper Management**: Swww for wallpaper switching with effects

### 🚀 System Components

-   **Login Manager**: Greetd with `tuigreet` for a fast, lightweight TUI login
-   **Terminal**: Kitty with custom themes and configurations
-   **Shell**: Zsh with Oh My Zsh, custom aliases, and prompt with fastfetch
-   **File Manager**: Thunar with plugins and custom actions
-   **Audio**: PipeWire with full ALSA and PulseAudio compatibility
-   **Notifications**: SwayNotificationCenter (swaync) with custom styling
-   **Screenshots**: Grim + Slurp + Swappy for screenshot workflow

### 🔧 Development Tools

-   **Editors**: VS Code, Neovim support
-   **Languages**: Full development environment for:
    -   **Node.js**: npm, yarn, TypeScript support
    -   **Python**: pip, virtualenv, development packages
    -   **Rust**: rustc, cargo
    -   **PHP**: composer, psalm
    -   **Go**: go, gopls, delve debugger
    -   **C/C++**: gcc, clang, make
-   **Containers**: Docker, Docker Compose
-   **Version Control**: Git, GitHub CLI
-   **Monitoring**: htop, btop, nvtop

### 🎮 Gaming & Entertainment

-   **Gaming Platforms**: Steam, Lutris, Heroic Game Launcher
-   **Game Tools**: ProtonUp-Qt for Proton management
-   **Media**: MPV with MPRIS support, yt-dlp
-   **Entertainment**: ani-cli for anime, manga-tui for manga

### 🔒 Security & Networking

-   **Network Analysis**: Wireshark, nmap
-   **Digital Forensics**: binwalk, foremost, steghide, stegseek, zsteg
-   **Password Cracking**: John the Ripper, hashcat
-   **Debugging**: GDB
-   **System Security**: Polkit integration, secure boot support

### 🖥️ Hardware Support

-   **Graphics Drivers**: Modular support for AMD, Intel, and NVIDIA
-   **NVIDIA Features**: PRIME support for laptops, CUDA compatibility
-   **Virtual Machines**: QEMU guest services, SPICE support
-   **Power Management**: CPU frequency scaling, zram swap
-   **Bluetooth**: Full Bluetooth stack with Blueman
-   **Printing**: Optional CUPS integration (commented out)

## 🚀 Installation

### Prerequisites

-   A working NixOS system
-   Git installed (`nix-shell -p git` if not available)
-   Root access for system configuration

### Quick Installation

**Option 1: Auto Installation (Recommended)**

```bash
curl -s https://raw.githubusercontent.com/Revprm/Nix-Hypr/master/auto-install.sh | bash
```

**Option 2: Manual Installation**

```bash
# Clone the repository
git clone https://github.com/Revprm/Nix-Hypr.git ~
cd ~/Nix-Hypr

# Run the installation script
chmod +x install.sh
./install.sh
```

### Installation Process

Both installation methods will:

1. **System Detection**: Automatically detect VM environment and GPU type
2. **Host Configuration**: Prompt for hostname (default: "default")
3. **Keyboard Layout**: Configure your preferred layout (default: "us")
4. **Hardware Configuration**: Generate hardware-specific settings
5. **User Setup**: Configure for the current user
6. **Driver Setup**: Enable appropriate graphics drivers automatically
7. **Dotfiles Installation**: Copy all configuration files to `~/.config`

### Supported Hardware

The configuration includes modular driver support:

-   **AMD**: Automatic AMDGPU driver configuration
-   **Intel**: Integrated graphics with hardware acceleration
-   **NVIDIA**: Proprietary drivers with Wayland support
-   **NVIDIA Prime**: Hybrid graphics for laptops
-   **Virtual Machines**: QEMU guest services and SPICE support

### Post-Installation

After installation completes:

1. Reboot your system (recommended)
2. Start Hyprland from the login screen
3. Customize settings in `hosts/<hostname>/variables.nix`

## 📂 Project Structure

```
NixOS-Hyprland/
├── 📄 flake.nix                    # Main flake configuration entry point
├── 🏠 hosts/                       # Host-specific configurations
│   ├── 📁 default/                 # Default host template
│   │   ├── config.nix              # Main system configuration
│   │   ├── packages-fonts.nix      # System packages and fonts
│   │   ├── users.nix               # User accounts and shell setup
│   │   ├── variables.nix           # Customizable variables
│   │   └── hardware.nix            # Auto-generated hardware config
│   └── 📁 prm/                     # Custom host example
│       └── ...                     # Same structure as default
├── 🧩 modules/                     # Modular system components
│   ├── amd-drivers.nix             # AMD graphics drivers
│   ├── intel-drivers.nix           # Intel graphics drivers
│   ├── nvidia-drivers.nix          # NVIDIA graphics drivers
│   ├── nvidia-prime-drivers.nix    # NVIDIA Prime for laptops
│   ├── quickshell.nix              # QuickShell desktop shell
│   ├── vm-guest-services.nix       # Virtual machine support
│   └── local-hardware-clock.nix    # Hardware clock configuration
├── ⚙️  config/                     # Application configurations
│   ├── 🎨 hypr/                    # Hyprland configuration
│   │   ├── hyprland.conf           # Main Hyprland config
│   │   ├── hyprlock.conf           # Lock screen config
│   │   ├── hypridle.conf           # Idle management
│   │   ├── monitors.conf           # Monitor settings
│   │   ├── workspaces.conf         # Workspace configuration
│   │   ├── animations/             # Animation presets
│   │   ├── scripts/                # Hyprland scripts
│   │   └── wallpaper_effects/      # Wallpaper transition effects
│   ├── 📊 waybar/                  # Status bar configuration
│   ├── 🚀 rofi/                    # Application launcher themes
│   ├── 💻 kitty/                   # Terminal configuration
│   ├── 🎵 cava/                    # Audio visualizer
│   ├── 📈 btop/                    # System monitor themes
│   ├── 🎨 wallust/                 # Color scheme generator
│   ├── 🔔 swaync/                  # Notification center
│   ├── 🎯 Kvantum/                 # Qt theming
│   ├── 🖱️  qt5ct/ & qt6ct/         # Qt configuration tools
│   ├── 🏃 quickshell/              # QuickShell configuration
│   ├── 📷 swappy/                  # Screenshot editor
│   └── 🚪 wlogout/                 # Logout menu
├── 🎨 assets/                      # Additional assets and configs
│   ├── fastfetch/                  # System info display configs
│   ├── gtk-3.0/                    # GTK theme settings
│   ├── Thunar/                     # File manager configuration
│   └── xfce4/                      # XFCE helper configurations
└── 🔧 Scripts/                     # Utility scripts
    ├── auto-install.sh             # Automated installation
    ├── install.sh                  # Manual installation
    ├── update.sh                   # System update script
    └── copy.sh                     # Configuration file deployment
```

### Key Components

#### 🏠 Host Configurations (`hosts/`)

Each host directory contains:

-   **`config.nix`**: Core system settings, services, and module imports
-   **`packages-fonts.nix`**: System-wide packages, fonts, and program configurations
-   **`users.nix`**: User accounts, groups, shell setup, and user-specific packages
-   **`variables.nix`**: Easily customizable variables (browser, terminal, git config, etc.)
-   **`hardware.nix`**: Auto-generated hardware configuration (created during installation)

#### 🧩 System Modules (`modules/`)

Modular components that can be enabled/disabled:

-   **Graphics Drivers**: Separate modules for AMD, Intel, NVIDIA, and NVIDIA Prime
-   **QuickShell**: Advanced desktop shell with Qt/QML support
-   **VM Support**: Guest services for virtual machine environments
-   **Hardware Clock**: Local time synchronization for dual-boot systems

#### ⚙️ Application Configs (`config/`)

Pre-configured dotfiles for all major applications, organized by program. These are automatically copied to `~/.config/` during installation.

#### 🎨 Assets (`assets/`)

Additional configuration files and themes that enhance the desktop experience.

## 🛠️ Customization

### Quick Configuration (`variables.nix`)

The easiest way to customize your setup is through `hosts/<hostname>/variables.nix`:

```nix
{
  # Git Configuration
  gitUsername = "YourUsername";
  gitEmail = "your.email@example.com";

  # Default Applications
  browser = "firefox";        # or "google-chrome-stable"
  terminal = "kitty";         # Default terminal emulator

  # System Settings
  keyboardLayout = "us";      # Keyboard layout
  clock24h = true;           # 24-hour clock format

  # Hyprland Settings
  extraMonitorSettings = ""; # Additional monitor configurations
}
```

### Host-Specific Customization

Create a new host configuration for different machines:

```bash
# During installation, specify a custom hostname
# This creates hosts/<hostname>/ with all necessary files
mkdir -p hosts/my-laptop
cp hosts/default/*.nix hosts/my-laptop/
```

Then modify `hosts/my-laptop/` files as needed:

#### User Packages (`users.nix`)

Add development tools or applications to your user:

```nix
packages = with pkgs; [
  # Your custom packages here
  discord
  blender
  gimp
  # Development tools
  jetbrains.idea-community
];
```

#### System Packages (`packages-fonts.nix`)

Add system-wide packages and configure programs:

```nix
environment.systemPackages = with pkgs; [
  # Add packages here
  neovim
  firefox
  code
];
```

#### Hardware Configuration (`config.nix`)

Enable/disable drivers and services:

```nix
# Graphics drivers (enable only what you need)
drivers = {
  amdgpu.enable = true;     # AMD graphics
  intel.enable = false;     # Intel graphics
  nvidia.enable = false;    # NVIDIA graphics
  nvidia-prime = {          # NVIDIA + Intel laptops
    enable = false;
    intelBusID = "PCI:0:2:0";
    nvidiaBusID = "PCI:1:0:0";
  };
};

# Virtual machine support
vm.guest-services.enable = false;  # Enable for VMs

# Local hardware clock (useful for dual-boot)
local.hardware-clock.enable = false;
```

### Application Theming

#### Waybar Customization

Edit `config/waybar/config` and `config/waybar/style.css` for status bar customization.

#### Hyprland Configuration

-   **Main config**: `config/hypr/hyprland.conf`
-   **Monitor setup**: `config/hypr/monitors.conf`
-   **Workspaces**: `config/hypr/workspaces.conf`
-   **Animations**: `config/hypr/animations/`
-   **Custom scripts**: `config/hypr/scripts/`

#### Rofi Themes

Multiple rofi configurations in `config/rofi/` for different purposes:

-   Application launcher
-   Emoji picker
-   Calculator
-   Clipboard manager
-   Theme selector

### System Updates

Keep your system updated with the provided update script:

```bash
# Update system with current hostname
./update.sh

# Update specific host configuration
./update.sh my-laptop
```

### Switching Configurations

To switch to a different host configuration:

```bash
sudo nixos-rebuild switch --flake .#hostname
```

### Adding New Modules

Create custom modules in the `modules/` directory:

```nix
# modules/my-custom-module.nix
{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.my.custom-module;
in {
  options.my.custom-module = {
    enable = mkEnableOption "My Custom Module";
  };

  config = mkIf cfg.enable {
    # Your configuration here
  };
}
```

Then import it in your host's `config.nix`:

```nix
imports = [
  # ... other imports
  ../../modules/my-custom-module.nix
];

# Enable it
my.custom-module.enable = true;
```

## � Requirements

### System Requirements

-   **Architecture**: x86_64-linux
-   **NixOS**: 24.11 or newer (using unstable channel)
-   **RAM**: 4GB minimum, 8GB+ recommended
-   **Storage**: 50GB+ available space
-   **Graphics**: Any modern GPU (AMD, Intel, or NVIDIA)

### Network Requirements

-   Internet connection for initial setup and package downloads
-   Access to GitHub and NixOS binary caches

## 🎯 Key Features Explained

### Flake-Based Configuration

This configuration uses NixOS flakes for:

-   **Reproducible builds**: Same configuration yields identical systems
-   **Version pinning**: Locked dependency versions ensure stability
-   **Easy rollbacks**: Built-in rollback capability
-   **Modular design**: Clean separation of concerns

### Multi-Host Support

-   **Template system**: Easy creation of new host configurations
-   **Shared modules**: Common functionality across all hosts
-   **Per-host customization**: Machine-specific settings
-   **Automatic detection**: Hardware and VM detection during installation

### Development Environment

The configuration includes a complete development setup:

-   **Multiple language support**: Node.js, Python, Rust, Go, PHP, C/C++
-   **Container tools**: Docker and Docker Compose
-   **Version control**: Git with GitHub CLI integration
-   **Editors**: VS Code, Neovim support
-   **Debugging tools**: Language-specific debuggers and profilers

## 🎮 Gaming Setup

### Included Gaming Tools

-   **Steam**: Full Steam integration with Proton support
-   **Lutris**: Game management for non-Steam games
-   **Heroic**: Epic Games Store and GOG launcher
-   **ProtonUp-Qt**: Easy Proton version management

### Performance Optimizations

-   **Kernel**: Latest or Zen kernel options
-   **Drivers**: Optimized graphics drivers for all GPU types
-   **Memory**: zram swap for better performance
-   **CPU**: Performance governor settings

## 🔒 Security Features

### System Security

-   **Polkit integration**: Secure privilege escalation
-   **Firewall configuration**: Customizable network security
-   **Secure boot support**: Optional secure boot compatibility
-   **User isolation**: Proper user/group permissions

### Development Security

-   **Container isolation**: Docker with proper security settings
-   **SSH configuration**: Secure SSH setup
-   **GPG integration**: Hardware-backed encryption support

## 📊 System Monitoring

### Built-in Monitoring Tools

-   **System**: htop, btop for system monitoring
-   **GPU**: nvtop for graphics card monitoring
-   **Network**: NetworkManager with GUI support
-   **Audio**: PipeWire with volume controls
-   **Storage**: Automatic TRIM support, disk usage tools

### Performance Monitoring

-   **CPU frequency**: Dynamic frequency scaling
-   **Memory**: zram compression and monitoring
-   **Storage**: SSD optimization and monitoring
-   **Thermals**: Automatic thermal management

## 🚨 Troubleshooting

### Common Issues

#### Boot Issues

```bash
# Switch to previous generation
sudo nixos-rebuild switch --rollback

# Check boot entries
sudo bootctl list
```

#### Graphics Issues

```bash
# Check graphics drivers
lspci -k | grep -A 2 -E "(VGA|3D)"

# Restart graphics session
systemctl --user restart hyprland-session.target
```

#### Package Issues

```bash
# Update flake inputs
nix flake update

# Rebuild with specific generation
sudo nixos-rebuild switch --flake .#hostname
```

#### Permission Issues

```bash
# Fix config permissions
sudo chown -R $USER:users ~/.config
chmod -R 755 ~/.config
```

### Logs and Debugging

```bash
# System logs
journalctl -f

# Hyprland logs
journalctl --user -f -u hyprland

# Check failed services
systemctl --failed
```

## 🔄 Updates and Maintenance

### Regular Updates

```bash
# Update system
./update.sh

# Update flake inputs
nix flake update && sudo nixos-rebuild switch --flake .#hostname
```

### Cleaning Up

```bash
# Clean old generations (keep last 3)
sudo nix-collect-garbage -d --delete-older-than 3d

# Optimize nix store
sudo nix-store --optimise
```

### Backup Configuration

```bash
# Backup current config
cp -r ~/.config ~/.config.backup.$(date +%Y%m%d)

# Version control your changes
git add . && git commit -m "Personal configuration changes"
```

## ❓ Frequently Asked Questions

### Q: Can I use this on a laptop?

A: Yes! The configuration includes NVIDIA Prime support for hybrid graphics laptops and power management optimizations.

### Q: Will this work in a virtual machine?

A: Absolutely! The installation script automatically detects VM environments and enables appropriate guest services.

### Q: How do I add my own wallpapers?

A: Place wallpapers in `~/.config/swww/` and use the wallpaper script in Hyprland or configure swww directly.

### Q: Can I use this with different desktop environments?

A: This configuration is specifically designed for Hyprland. For other DEs, you'd need to modify the window manager configuration.

### Q: How do I switch between different Hyprland configurations?

A: Use the rofi menus (Super+T) to switch between themes, or edit the configuration files directly.

### Q: What if I want to use X11 instead of Wayland?

A: This configuration is Wayland-native. For X11, you'd need to replace Hyprland with a different window manager and update the configurations accordingly.

## 🤝 Contributing

### Reporting Issues

1. Check existing issues first
2. Provide system information (`nixos-version`, `uname -a`)
3. Include relevant logs and error messages
4. Describe steps to reproduce

### Submitting Changes

1. Fork the repository
2. Create a feature branch
3. Test your changes thoroughly
4. Submit a pull request with detailed description

### Development Guidelines

-   Follow Nix formatting conventions
-   Test on multiple hardware configurations when possible
-   Document significant changes
-   Keep modules modular and optional

## 📚 Resources

### Learning NixOS

-   [NixOS Manual](https://nixos.org/manual/nixos/stable/)
-   [Nix Language Tutorial](https://nixos.org/guides/nix-language.html)
-   [NixOS Wiki](https://nixos.wiki/)

### Hyprland Resources

-   [Hyprland Wiki](https://wiki.hyprland.org/)
-   [Hyprland Configuration](https://wiki.hyprland.org/Configuring/Configuring-Hyprland/)
-   [Waybar Configuration](https://github.com/Alexays/Waybar/wiki)

### Community

-   [NixOS Discourse](https://discourse.nixos.org/)
-   [Hyprland Discord](https://discord.gg/hQ9XvMUjjr)
-   [r/NixOS](https://reddit.com/r/NixOS)

## 📄 License

This configuration is provided as-is under the MIT License. Feel free to modify and distribute according to your needs.

## 🙏 Credits and Acknowledgments

### Primary Attribution

-   **[JaKooLit](https://github.com/JaKooLit)**: Original NixOS-Hyprland configuration and installation scripts
-   **[Hyprland Team](https://github.com/hyprwm/Hyprland)**: The amazing Wayland compositor
-   **[NixOS Community](https://nixos.org/)**: The innovative Linux distribution

### Theme and Design Credits

-   **[Catppuccin](https://github.com/catppuccin)**: Beautiful color schemes used throughout
-   **[Bibata Cursors](https://github.com/ful1e5/Bibata_Cursor)**: Modern cursor theme
-   **[JetBrains](https://www.jetbrains.com/lp/mono/)**: JetBrains Mono font family

### Tool Authors

-   **Waybar**: [Alexays](https://github.com/Alexays/Waybar)
-   **Rofi**: [DaveDavenport](https://github.com/davatorium/rofi)
-   **QuickShell**: [outfoxxed](https://git.outfoxxed.me/outfoxxed/quickshell)
-   **Wallust**: [explosion-mental](https://github.com/explosion-mental/wallust)

### Special Thanks

-   All contributors and users who provide feedback and improvements
-   The NixOS and Hyprland communities for their support and resources
-   Beta testers who helped refine this configuration

---

<div align="center">

**⭐ If you find this configuration helpful, please consider starring the repository! ⭐**

[Report Bug](../../issues) • [Request Feature](../../issues) • [Discussions](../../discussions)

</div>
