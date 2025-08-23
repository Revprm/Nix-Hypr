{ config, pkgs, host, username, options, lib, inputs, system, ... }:
let inherit (import ../variables.nix) keyboardLayout;

in {
  programs.regreet = {
    enable = true;
    settings = {
      general = {
        default_session = "hyprland";
        style = "~/.config/regreet/regreet.css";
        locale = "en_US.UTF-8";
      };
      layout = {
        orientation = "vertical";
        spacing = 15;
        padding = 20;
        border_radius = 20;
      };
      title = {
        show = true;
        align = "center";
        font_size = 18;
      };
      users = {
        show = true;
        show_avatar = true;
        align = "center";
        orientation = "vertical";
        border_radius = 12;
        spacing = 10;
      };
      password = {
        show = true;
        placeholder = "Enter password...";
        border_radius = 10;
      };
      login_button = {
        text = "Login";
        border_radius = 12;
        expand = true;
        align = "center";
      };
      actions = {
        show = true;
        orientation = "horizontal";
        align = "center";
        spacing = 12;
        border_radius = 10;
      };
    };
    extraCss = ''
      /* Tokyo Night System24 Style for Regreet */

      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 14px;
        color: #c0caf5;
      }

      window {
        background-color: #1a1b26;
        border-radius: 20px;
        border: 2px solid #3d59a1;
        padding: 20px;
      }

      /* Title (hostname / session text) */
      label#title {
        font-size: 18px;
        font-weight: bold;
        color: #7aa2f7;
        margin-bottom: 10px;
      }

      /* User selection box */
      box#users {
        background-color: #1f2335;
        border-radius: 12px;
        border: 1px solid #414868;
        padding: 10px;
      }

      /* Each user entry */
      button.user {
        background-color: transparent;
        border-radius: 12px;
        padding: 10px;
        margin: 6px;
        transition: background 0.2s ease;
      }

      button.user:hover {
        background-color: #2f334d;
        border: 1px solid #7aa2f7;
      }

      /* Password entry */
      entry {
        background-color: #1f2335;
        border-radius: 10px;
        border: 1px solid #414868;
        padding: 8px;
        margin-top: 12px;
        color: #c0caf5;
      }

      entry:focus {
        border: 1px solid #7aa2f7;
        background-color: #2a2e45;
      }

      /* Login button */
      button#login {
        background-color: #3d59a1;
        color: #c0caf5;
        font-weight: bold;
        border-radius: 12px;
        margin-top: 15px;
        padding: 8px 12px;
        border: none;
        transition: background 0.2s ease;
      }

      button#login:hover {
        background-color: #7aa2f7;
        color: #1a1b26;
      }

      /* Power buttons (shutdown, restart, etc.) */
      box#actions button {
        background-color: transparent;
        border: none;
        margin: 8px;
        padding: 8px;
        border-radius: 10px;
        transition: background 0.2s ease;
      }

      box#actions button:hover {
        background-color: #2f334d;
      }
    '';
  };
}
