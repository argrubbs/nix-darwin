# home.nix
# home-manager switch
{ pkgs, ... }:
{
  imports = [
    ./modules/emacs.nix
    #    ./modules/vscode.nix
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
    pkgs.vscode
    pkgs.nodejs
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.ansible-navigator
    pkgs.molecule
    pkgs.btop
    pkgs.git
    pkgs.gitAndTools.gh
    pkgs.nixfmt
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
      echo "🚀 Home Manager zsh loaded with Starship prompt!"
      
      # Enable Starship prompt
      eval "$(starship init zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$all$character";
      
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      
      directory = {
        style = "bold cyan";
        truncation_length = 3;
        truncate_to_repo = false;
      };
      
      git_branch = {
        symbol = "🌱 ";
        style = "bold purple";
      };
      
      git_status = {
        style = "bold yellow";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        conflicted = "🏳";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[++(\${count})](green)";
        renamed = "👅";
        deleted = "🗑";
      };
      
      cmd_duration = {
        min_time = 2000;
        format = "underwent [$duration](bold yellow)";
        show_milliseconds = false;
      };
      
      hostname = {
        ssh_only = false;
        format = "on [$hostname](bold red) ";
        disabled = false;
      };
      
      username = {
        style_user = "bold blue";
        show_always = true;
        format = "[$user]($style) ";
      };
      
      nix_shell = {
        symbol = "❄️ ";
        style = "bold blue";
        format = "via [$symbol$state( \($name\))]($style) ";
      };
      
      package = {
        symbol = "📦 ";
        style = "bold 208";
      };
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = "
      set -g mouse on
      setw -g mode-keys vi
      set -g prefix C-a";
  };

  programs.git = {
    enable = true;
    userName = "argrubbs";
    userEmail = "argrubbs@users.noreply.github.com";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      core.editor = "code --wait";
    };
  };
}
