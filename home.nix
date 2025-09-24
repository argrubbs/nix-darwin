# home.nix
# home-manager switch
{pkgs, ...}: {
  imports = [
    ./modules/emacs.nix
    ./modules/vscode.nix
  ];
  home.username = "adamgrubbs";
  home.homeDirectory = "/Users/adamgrubbs";
  home.stateVersion = "25.05";

  home.packages = [
    pkgs.tmux
    pkgs.stow
    pkgs.brave
    pkgs.claude-code
                pkgs.claude-monitor
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza --all --long --icons";
      update = "sudo darwin-rebuild switch --flake ~/nix#sterling";
      emacs-restart = "launchctl unload ~/Library/LaunchAgents/org.nix-community.home.emacs.plist && launchctl load ~/Library/LaunchAgents/org.nix-community.home.emacs.plist";
    };
    history.size = 10000;
    initContent = ''
      # Home Manager managed zsh configuration
      echo "Home Manager zsh loaded"
    '';
  };

  home.file = {
    ".tmux.conf".text = ''
      set -g prefix ^A
    '';
  };
}
