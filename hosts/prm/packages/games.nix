{ pkgs, ... }:

{
  games-packages = with pkgs;
    [
      # Games
      osu-lazer-bin
      opentabletdriver
    ];
}
