{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    extensions = with pkgs.vscode-extensions; [
      # Ansible
      redhat.ansible

      # Python
      ms-python.python
      ms-python.vscode-pylance

      # GitHub Copilot
      github.copilot
      github.copilot-chat

      # Nix
      jnoortheen.nix-ide

      # TokyoNight theme
      enkia.tokyo-night
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # Nix Extensions Pack (additional nix extensions)
      {
        name = "nix-extension-pack";
        publisher = "pinage404";
        version = "1.0.0";
        sha256 = "sha256-/E/7bKdGVOyTKIUePVTJEwI0ztVWPzpfLAiQM3bD7Fc=";
      }
    ];

    userSettings = {
      "workbench.colorTheme" = "Tokyo Night";
      "editor.fontFamily" = "'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace";
      "editor.fontSize" = 13;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "editor.formatOnSave" = true;
      "extensions.autoUpdate" = true;
      "github.copilot.enable" = {
        "*" = true;
        "yaml" = true;
        "plaintext" = false;
        "markdown" = true;
      };
    };
  };
}