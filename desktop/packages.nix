{ pkgs, ... }:

{
  # Licensing
  nixpkgs.config.allowUnfree = true; # Allows pulling proprietary binaries like Steam or Corefonts

  # System-Wide Font Management
  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
  ];

  # System-Wide Applications and Development Tools
  environment.systemPackages = with pkgs; [
    # Core Utilities & Security Infrastructure
    git
    wget
    gnupg
    cmake
    ffmpeg-full   # Global media encoding pipeline support
    wimlib        # Essential for deploying/modifying Windows disk images (WIM) for KVMs
    android-tools # ADB & Fastboot deployment tools

    # Core Graphics Rendering Utilities
    libva
    libva-utils
    mesa
    mesa-gl-headers

    # Mesh Networking Graphical Interface
    netbird-ui

    # Local AI & Machine Learning Acceleration
    ollama-vulkan # Leverages Vulkan computing layer instead of regular CPU rendering

    # Desktop UI Assets & Look-and-Feel Injections
    #pkgs.sddm-astronaut-theme # FIX: Installs theme files directly so SDDM can find them at boot

    # Advanced Guest VM Integration Helpers
    # (Note: 'qemu' and 'virt-manager' binaries are managed automatically via services)
    spice
    spice-gtk
    spice-protocol
    virtio-win    # Windows Guest WHQL driver storage/network ISO optimization layers
    win-spice     # High-performance display drivers for Windows virtualization layers
  ];

  # Advanced Low-Level Hardware Configuration
  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true; # Automatically grabs unfree firmware blobs for device compatibility

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd # OpenCL runtime layer for AMD GPUs (Essential for heavy Ollama workloads)
        rocmPackages.tensile # Hardware-level matrix multiplication acceleration library
      ];
    };
  };

  # Stock KDE Bloat Elimination
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole # Removed because you are using Zsh inside a customized Kitty profile
    elisa   # Removed default media player to prevent menu clutter
  ];
}
