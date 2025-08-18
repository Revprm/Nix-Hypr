{ pkgs, ... }:

{
  social-packages = with pkgs; [
    # Communication
    zapzap
    zoom-us
    betterdiscordctl
  ];
}
