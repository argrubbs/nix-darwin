{
  description = "Sterling nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "github:argrubbs/dotfiles";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    home-manager,
    dotfiles,
  }: let
    configuration = {pkgs, ...}: {
      nix.enable = false;
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = [
        pkgs.neovim
        pkgs.wezterm
        pkgs.zoxide
        pkgs.eza
        pkgs.fzf
        pkgs.ripgrep
        pkgs.bat
        pkgs.brave
      ];

      programs.zsh.enable = true;

      programs._1password = {
        enable = true;
      };

      programs._1password-gui = {
        enable = true;
      };

      users.users.adamgrubbs = {
        name = "adamgrubbs";
        home = "/Users/adamgrubbs";
        shell = pkgs.zsh;
      };
      home-manager.backupFileExtension = "backup";

      environment.systemPath = [
        "/run/current-system/sw/bin"
        "/usr/local/bin"
        "/usr/bin"
        "/bin"
      ];

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        casks = [
          "claude"
          "colemak-dh"
          "emacs-app"
          "shortcat"
          "brave-browser"
        ];
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.primaryUser = "adamgrubbs";
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."sterling" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.adamgrubbs = import ./home.nix;
          home-manager.extraSpecialArgs = {inherit dotfiles;};
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
            };
            mutableTaps = false;
            user = "adamgrubbs";
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
