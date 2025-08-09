{ config, pkgs, host, username, options, lib, inputs, system, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Kernel
    kernelParams = [
      "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
    ];
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };
    kernel.sysctl = { "vm.max_map_count" = 2147483642; };
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      gfxmodeBios = "auto";
      memtest86.enable = true;
      extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
      configurationName = "${host}";
    };
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
  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };
}
