{ config, pkgs, host, username, options, lib, inputs, system, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device"
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco"
      "modprobe.blacklist=iTCO_wdt"
    ];
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };
    loader.systemd-boot.enable = true;
    loader.efi = { canTouchEfiVariables = true; };
    loader.timeout = 5;
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
      magicOrExtension = "\\x7fELF....AI\\x02";
    };
    plymouth.enable = true;
  };
}
