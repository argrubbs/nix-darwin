# home.nix
# home-manager switch
{pkgs, ...}: {
  home.username = "adamgrubbs";
  home.homeDirectory = "/Users/adamgrubbs";
  home.stateVersion = "25.05";

  home.packages = [
    pkgs.tmux
    pkgs.stow
    pkgs.brave
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
