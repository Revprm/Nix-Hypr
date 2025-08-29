{ pkgs, ... }:

{
  social-packages = with pkgs; [
    # Communication
    zapzap
    betterdiscordctl
  ];
}
