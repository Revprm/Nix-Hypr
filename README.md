# NixOS Hyprland Config

This is my personal NixOS setup using the Hyprland window manager, based on [JaKooLit's configuration](https://github.com/JaKooLit/NixOS-Hyprland).

## ✨ What's Included?

  * **Compositor**: Hyprland
  * **Status Bar**: Waybar
  * **App Launcher**: Rofi
  * **Terminal**: Kitty
  * **Development**: VS Code, Node.js, Python, Rust, Go, PHP, C/C++
  * **Gaming**: Steam, Lutris, Heroic
  * **Drivers**: Support for AMD, Intel, and NVIDIA
  * **Theme**: Catppuccin

## 🚀 Quick Install

**Recommended:**

```bash
curl -s https://raw.githubusercontent.com/Revprm/Nix-Hypr/master/auto-install.sh | bash
```

**Manual Install:**

```bash
git clone https://github.com/Revprm/Nix-Hypr.git ~/Nix-Hypr
cd ~/Nix-Hypr
chmod +x install.sh && ./install.sh
```

The installer will guide you through setting your hostname and keyboard layout, then install everything. Reboot when it's done\!

## ⚙️ Customization

You can easily change basic settings by editing the `hosts/<hostname>/variables.nix` file:

```nix
{
  gitUsername = "YourName";
  gitEmail = "your@email.com";
  browser = "firefox";
  terminal = "kitty";
  keyboardLayout = "us";
}
```

For more advanced changes, you can add packages in `users.nix` or adjust hardware settings in `config.nix`.

## 🔧 Updates

To keep your system up to date, just run the update script:

```bash
./update.sh
```

## 🙏 Credits

A big thanks to **[JaKooLit](https://github.com/JaKooLit)** for the original configuration that this is based on.
