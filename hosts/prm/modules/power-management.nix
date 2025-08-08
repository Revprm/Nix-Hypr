{ config, pkgs, lib, ... }:

{
  powerManagement = {
    enable = true;
    # schedutil is good for modern CPUs - balances performance and efficiency
    cpuFreqGovernor = "schedutil";

    # Enable CPU frequency scaling
    cpufreq.max = null; # Let the system decide
    cpufreq.min = null; # Let the system decide
  };

  services.tlp = {
    enable = true;
    settings = {
      # --- AC Power Settings (Gaming & High Performance) ---

      # CPU Performance
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;

      # For multitasking: Allow some CPU threads to scale down when not needed
      CPU_SCALING_MIN_FREQ_ON_AC = 800000; # 800MHz minimum
      CPU_SCALING_MAX_FREQ_ON_AC = 0; # 0 = no limit, use max turbo

      # Intel P-State driver settings (if using Intel CPU)
      CPU_MIN_PERF_ON_AC = 5; # 10% minimum performance
      CPU_MAX_PERF_ON_AC = 99; # 100% maximum performance

      # Platform Profile (if supported)
      PLATFORM_PROFILE_ON_AC = "performance";

      # PCIe Power Management - Critical for gaming
      PCIE_ASPM_ON_AC = "performance";

      # Disk I/O Performance
      DISK_IDLE_SECS_ON_AC = 0; # Disable disk idle
      MAX_LOST_WORK_SECS_ON_AC = 15; # Reduce data loss window

      # USB Power Management
      USB_AUTOSUSPEND = 0; # Disable USB autosuspend
      USB_BLACKLIST_PHONE = 1; # Don't suspend phones

      # Audio Power Management
      SOUND_POWER_SAVE_ON_AC = 0; # Disable audio power saving

      # WiFi Power Management
      WIFI_PWR_ON_AC = "off"; # Disable WiFi power saving

      # Runtime Power Management for PCIe devices
      RUNTIME_PM_ON_AC = "auto"; # Let kernel decide

      # --- Battery Power Settings (Efficiency & Decent Performance) ---

      # CPU Settings - Balanced for multitasking
      CPU_SCALING_GOVERNOR_ON_BAT =
        "schedutil"; # Better than powersave for responsiveness
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance"; # Good balance
      CPU_BOOST_ON_BAT = 1; # Keep turbo enabled but controlled

      # CPU Frequency limits
      CPU_SCALING_MIN_FREQ_ON_BAT = 800000; # 800MHz minimum
      CPU_SCALING_MAX_FREQ_ON_BAT = 2400000; # Limit max freq to extend battery

      # Intel P-State settings for battery
      CPU_MIN_PERF_ON_BAT = 5; # 5% minimum performance
      CPU_MAX_PERF_ON_BAT = 80; # 80% maximum performance

      # Platform Profile
      PLATFORM_PROFILE_ON_BAT = "balanced";

      # PCIe Power Management
      PCIE_ASPM_ON_BAT = "powersupersave"; # Aggressive power saving

      # Disk Power Management
      DISK_IDLE_SECS_ON_BAT = 2; # Spin down after 2 seconds
      MAX_LOST_WORK_SECS_ON_BAT = 60; # Longer write-back interval

      # Enable SATA Link Power Management
      SATA_LINKPWR_ON_BAT = "med_power_with_dipm";

      # Audio Power Management
      SOUND_POWER_SAVE_ON_BAT = 1; # Enable audio power saving
      SOUND_POWER_SAVE_CONTROLLER = 1; # Power save audio controller

      # WiFi Power Management
      WIFI_PWR_ON_BAT = "on"; # Enable WiFi power saving

      # Runtime Power Management
      RUNTIME_PM_ON_BAT = "auto"; # Enable runtime PM

      # --- Advanced Battery Optimization ---

      # Battery Charge Thresholds (if supported by your laptop)
      START_CHARGE_THRESH_BAT0 = 40; # Start charging at 40%
      STOP_CHARGE_THRESH_BAT0 = 100; # Stop charging at 80%

      # Radeon GPU Power Management (if you have AMD integrated graphics)
      RADEON_POWER_PROFILE_ON_AC = "high";
      RADEON_POWER_PROFILE_ON_BAT = "low";
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

      # Kernel Power Management
      NMI_WATCHDOG = 0; # Disable NMI watchdog to save power

      # --- Multitasking Optimizations ---

      # Don't be too aggressive with USB power management for peripherals
      USB_BLACKLIST_BTUSB = 1; # Don't suspend Bluetooth
      USB_BLACKLIST_WWAN = 1; # Don't suspend WWAN modems

      # Keep network responsive
      WOL_DISABLE = "N"; # Allow Wake-on-LAN

      # Optical drive power management
      BAY_POWEROFF_ON_BAT = 1; # Power off optical drive on battery

      # --- GPU Specific Settings ---
      # Note: NVIDIA GPU performance is handled by the proprietary driver
      # These settings optimize the integrated GPU and system components
    };
  };

  # Disable power-profiles-daemon to avoid conflicts with TLP
  services.power-profiles-daemon.enable = false;

  # Additional power management services
  services.thermald.enable = true; # Thermal management (Intel CPUs)
  services.irqbalance.enable = true; # Balance IRQs across CPU cores
  services.earlyoom.enable = true; # Prevent system freezes from OOM

  # Kernel parameters for better power management and multitasking
  boot.kernel.sysctl = {
    # Additional multitasking optimizations
    "vm.swappiness" = 10; # Reduce swap usage
    "vm.vfs_cache_pressure" = 50; # Keep filesystem cache longer
    "kernel.sched_autogroup_enabled" = 1; # Better desktop responsiveness
  };
}
