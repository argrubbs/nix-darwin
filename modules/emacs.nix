{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-macport;
    extraConfig = ''
      ;; Basic Emacs configuration
      (setq inhibit-startup-message t)
      (setq make-backup-files nil)
      (setq auto-save-default nil)

      ;; macOS-specific optimizations
      (when (eq system-type 'darwin)
        (setq mac-command-modifier 'meta)
        (setq mac-option-modifier 'super)
        (setq ns-use-native-fullscreen t))

      ;; UI improvements
      (tool-bar-mode -1)
      (menu-bar-mode -1)
      (scroll-bar-mode -1)
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)

      ;; Better defaults
      (setq-default indent-tabs-mode nil)
      (setq-default tab-width 2)
      (setq ring-bell-function 'ignore)

      ;; Enable useful modes
      (electric-pair-mode 1)
      (show-paren-mode 1)
      (global-auto-revert-mode 1)

      ;; Theme and visual setup
      (require 'doom-themes)
      (load-theme 'doom-laserwave t)
      (require 'doom-modeline)
      (doom-modeline-mode 1)

      ;; Org configuration
      (setq org-directory "~/org/")

      ;; Modern completion setup
      (require 'vertico)
      (vertico-mode 1)
      (require 'marginalia)
      (marginalia-mode 1)
      (require 'corfu)
      (global-corfu-mode 1)
      (corfu-popupinfo-mode 1)

      ;; Configure orderless
      (require 'orderless)
      (setq completion-styles '(orderless basic)
            completion-category-defaults nil
            completion-category-overrides '((file (styles partial-completion))))

      ;; Consult configuration
      (require 'consult)
      (setq consult-narrow-key "<")
      (global-set-key (kbd "C-s") 'consult-line)
      (global-set-key (kbd "C-x b") 'consult-buffer)
      (global-set-key (kbd "M-y") 'consult-yank-pop)
      (global-set-key (kbd "C-c f") 'consult-find)
      (global-set-key (kbd "C-c r") 'consult-ripgrep)

      ;; Cape configuration for completion
      (require 'cape)
      (add-to-list 'completion-at-point-functions #'cape-dabbrev)
      (add-to-list 'completion-at-point-functions #'cape-file)
    '';
    extraPackages = epkgs: with epkgs; [
      use-package
      vertico
      orderless
      marginalia
      consult
      corfu
      cape
      evil
      which-key
      magit
      projectile
      doom-themes
      doom-modeline
      gptel
    ];
  };

  # Enable emacs daemon service
  services.emacs = {
    enable = true;
    package = config.programs.emacs.finalPackage;
    client.enable = true;
  };

  # Link Nix Emacs.app to /Applications
  home.file."/Applications/Emacs.app".source = "${config.programs.emacs.finalPackage}/Applications/Emacs.app";
}