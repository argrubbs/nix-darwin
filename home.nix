# home.nix
# home-manager switch
{
  pkgs,
  dotfiles,
  ...
}: {
  home.username = "adamgrubbs";
  home.homeDirectory = "/Users/adamgrubbs";
  home.stateVersion = "25.05";

  home.packages = [
    pkgs.tmux
  ];

  home.file = {
    ".tmux.conf".text = ''
      set -g prefix ^A
    '';
    ".zshrc".source = "${dotfiles}/.zshrc";
    ".test-dotfiles".text = "Dotfiles path: ${dotfiles}";
  };
}
