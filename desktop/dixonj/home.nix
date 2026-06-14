{ inputs, config, pkgs, lib, ... }:

{
  home = {
    username = "dixonj";
    homeDirectory = "/home/dixonj";
    stateVersion = "25.11";
    enableNixpkgsReleaseCheck = false;

    # User-space packages (Kept clean of core system shells)
    packages = with pkgs; [
      # Modern Terminal CLI Replacements
      bat
      bottom
      eza
      dysk
      fd
      fastfetch
      neovim
      procs
      ripgrep
      tealdeer
      tree
      xh

      # Graphic Design & Creation Suite
      gimp
      godot
      inkscape

      # Native KDE Utility Overrides
      kdePackages.kleopatra
      kdePackages.kdenlive
      kdePackages.discover

      # Standard Daily Applications
      keepassxc
      librewolf
      libreoffice
      onlyoffice-desktopeditors
      signal-desktop
      tutanota-desktop
      vlc
      vesktop
      vscodium
      zed-editor-fhs

      # Specialized / Productivity Utilities
      nil # Nix Language Server
      nix-search
      prismlauncher # High-performance Minecraft gaming wrapper
      protonup-qt
      protonup-ng
      wl-clipboard
      wireshark-cli
      hexchat

      # System Font Styling
      nerd-fonts.fira-code
    ];
  };

  # Local User Services
  services = {
    kdeconnect.enable = true;
  };

  # Declarative Program Control Layouts
  programs = {
    home-manager.enable = true;

    # User-space Git Identification
    git = {
      enable = true;
      userName = "JordanDev-Foss";
      userEmail = "jordandixon@jrips.org";
      extraConfig = {
        init.defaultBranch = "master";
      };
    };

    # Custom High-Performance Kitty Terminal
    kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font Mono";
        package = pkgs.nerd-fonts.fira-code;
        size = 16;
      };
      shellIntegration.enableZshIntegration = true;
      themeFile = "CLRS";
      extraConfig = ''
        background_image ~/nix-flake/assets/notebook.jpg
        initial_window_width 1360
        initial_window_height 1000
        remember_window_size no
      '';
    };

    # Interactive User Zsh Optimization Profile
    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      autosuggestion.enable = true;

      # FIX: Changed 'initContent' to the official 'initExtra' hook
      initExtra = ''
        cat ~/nix-flake/scripts/ascii.txt
        fastfetch -c examples/2.jsonc
      '';

      # Optimized Productivity Aliases
      shellAliases = {
        ssh = "kitten ssh"; # Optimizes Kitty terminal environment mapping over remote machines
        gc = "nix-collect-garbage -d; sudo nix-collect-garbage -d";
        ls = "eza --icons -hal";
        cat = "bat";
        find = "fd";
        grep = "rg";
        top = "btm";
        curl = "xh";
        df = "dysk -a";

        # Display Environment Controls
        logout = "qdbus org.kde.Shutdown /Shutdown logout";
        poweroff = "qdbus org.kde.Shutdown /Shutdown logoutAndShutdown";
        reboot = "qdbus org.kde.Shutdown /Shutdown logoutAndReboot";

        # System Builds & Checks
        update = "$HOME/nix-flake/scripts/update.sh";
        speedtest = "xh --download http://speedtest.tele2.net/20MB.zip";
        rebuild = "sudo nixos-rebuild switch --impure --offline --flake /home/dixonj/nix-flake";

        # System Fetch Customizations
        fastfetch = "cat $HOME/nix-flake/scripts/ascii.txt; fastfetch -c examples/2.jsonc";
        neofetch = "cat $HOME/nix-flake/scripts/ascii.txt; fastfetch -c examples/2.jsonc";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "duellj";
      };
    };
  };
}
