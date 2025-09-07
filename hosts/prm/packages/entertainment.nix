{ pkgs, ... }:

{
  entertainment-packages = with pkgs; [
    # Anime & Manga
    ani-cli
    manga-tui
    suwayomi-server
    spicetify-cli
  ];
}
