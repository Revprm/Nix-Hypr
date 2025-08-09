{ config, pkgs, host, username, options, lib, inputs, system,, ... }:
let inherit (import ../variables.nix) keyboardLayout;

in {
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = username;
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        };
      };
    };
    smartd = {
      enable = false;
      autodetect = true;
    };
    gvfs.enable = true;
    tumbler.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    libinput.enable = true;
    rpcbind.enable = false;
    nfs.server.enable = false;
    openssh.enable = true;
    flatpak.enable = true;
    blueman.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    gnome.gnome-keyring.enable = true;
  };
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
