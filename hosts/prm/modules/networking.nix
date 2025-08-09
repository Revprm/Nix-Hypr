{ config, pkgs, host, username, options, lib, inputs, system, ... }: {
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  };
  services.automatic-timezoned.enable = true;
}
