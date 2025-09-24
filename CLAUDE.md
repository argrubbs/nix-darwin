# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix-based macOS system configuration using nix-darwin and home-manager. The system is named "sterling" and manages both system-level packages and user-level configurations for user `adamgrubbs`.

## Commands

### System Management
- **Apply system configuration**: `sudo darwin-rebuild switch --flake ~/nix#sterling`
  - This command is aliased as `update` in the shell
- **Build without switching**: `darwin-rebuild build --flake ~/nix#sterling`
- **Apply home-manager only**: `home-manager switch`

### Development
- **Update flake inputs**: `nix flake update`
- **Check flake**: `nix flake check`
- **Commit changes**: Always commit any changes made by Claude to the local main git branch

## Architecture

### Configuration Structure
- **flake.nix**: Main system flake defining the "sterling" darwin configuration
  - Integrates nix-darwin, home-manager, and nix-homebrew
  - Defines system packages and homebrew casks
  - Configures user `adamgrubbs` with zsh shell
- **home.nix**: Home-manager configuration for user environment
  - User-specific packages and dotfile management
  - Shell configuration and aliases
- **modules/**: Directory for modular configuration files (currently minimal)

### Key Components
- **System Packages**: Managed through nixpkgs in flake.nix (neovim, wezterm, zoxide, eza, fzf, ripgrep, bat, brave)
- **User Packages**: Managed through home-manager in home.nix (tmux, stow, brave, claude-code)
- **Homebrew Integration**: Managed casks including claude, colemak-dh, shortcat
- **Shell**: zsh with completion, autosuggestions, and syntax highlighting enabled

### Platform
- Target platform: aarch64-darwin (Apple Silicon)
- System state version: 6
- Home-manager state version: 25.05

## Configuration Files
- System-level configuration lives in modules/configuration.nix
- User-level configuration is imported from home.nix
- TouchID authentication is enabled for sudo
- 1Password integration is configured at system level