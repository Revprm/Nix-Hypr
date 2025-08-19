final: prev: {
  spicetify-cli = prev.spicetify-cli.overrideAttrs (oldAttrs: {
    pname = "spicetify-cli";
    version = "2.41.0";

    src = prev.fetchFromGitHub {
      owner = "spicetify";
      repo = "cli";
      tag = "v${oldAttrs.version}";
      hash = "sha256-CVCp9XzbVM0XAtgtBfMLLQTymzMTZfpoL9RrLI9MaDY=";
    };
    vendorHash = "sha256-iD6sKhMnvc0RczoSCWCx/72/zjoC6YQyV+AYyE4w/b0=";
  });
}
