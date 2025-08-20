self: super: {
  osu-lazer-bin = super.osu-lazer-bin.overrideAttrs (oldAttrs:
    let version = "2025.816.0";
    in {
      pname = "osu-lazer-bin";
      inherit version;

      src = super.fetchurl {
        url =
          "https://github.com/ppy/osu/releases/download/${version}-lazer/osu.AppImage";
        hash = "sha256-mOihQ8mtHEiq0FElkJiZl0mhBqPi8CoGowN358Jc72A=";
      };
    });
}
