{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Boot Initialization Kernel Hardware Mappings
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
  boot.initrd.kernelModules = [ "usb_storage" ];
  boot.kernelModules = [ "kvm-amd" "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" ];
  boot.extraModulePackages = [ ];

  # Secure LUKS Disk Decryption Environment
  boot.initrd.luks.devices."nixos" = {
    device = "/dev/disk/by-uuid/28064949-e2cb-41c1-8ea2-7a97d0b0e53f";
    allowDiscards = true;

    # Raw keyfile validation properties
    # TIP: If your keyfile drive path shifts around, swap "/dev/sda" below
    # to a persistent path like "/dev/disk/by-id/usb-YOUR_DRIVE_ID_HERE"
    keyFile = "/dev/sda";
    keyFileSize = 4096;

    # MODERN FALLBACK: We pass password fallback directly to the systemd-cryptsetup engine.
    # "keyfile-timeout=5" tries the file for 5 seconds; if it fails or the device isn't found,
    # systemd automatically prompts for your passphrases on screen.
    crypttabExtraOpts = [
      "keyfile-timeout=5"
      "password-echo=no"
    ];
  };

  # Core File System Layout
  fileSystems."/" = {
    device = "/dev/mapper/nixos";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" "ssd" ];
  };

  # UEFI Boot Partition Mapping
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/187B-A494";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # Virtual Memory Swap Volume
  swapDevices = [
    { device = "/dev/disk/by-uuid/f27bd1ba-5a6c-4331-83da-8af0e408d3db"; }
  ];

  # Platform & CPU Architecture Optimizations
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
