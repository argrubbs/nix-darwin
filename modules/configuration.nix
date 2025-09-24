{pkgs, self, ...}: {
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

  security.pam.services.sudo_local.touchIdAuth = true;

  programs._1password = {
    enable = true;
  };

  programs._1password-gui = {
    enable = true;
  };
  programs.zsh.enable = true;
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
    brewPrefix = "/opt/homebrew/bin";
    casks = [
      "claude"
      "colemak-dh"
      "shortcat"
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
}