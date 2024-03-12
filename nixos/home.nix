{ config, pkgs, ... }:

{
  home.username = "kp";
  home.homeDirectory = "/home/kp";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [
    pkgs.dconf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "mafredri/zsh-async"; }
        { name = "sindresorhus/pure"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zap-zsh/sudo"; }
        { name = "MichaelAquilina/zsh-you-should-use"; }
        { name = "chivalryq/git-alias"; }
        { name = "zap-zsh/completions"; }
        # { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };

    shellAliases = {
      code = "codium";

      update = "sudo nixos-rebuild switch --flake ~/.config/kp/nixos/#default";

      # git
      g = "git";

      # npm package managers
      y = "yarn";
      pp = "pnpm";
      pps = "pnpm start";
      ppi = "pnpm install";

      # Colorize grep output (good for log files)
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";

      # ls replacement
      ls = "eza --icons";
      lsa = "ls -al";
      lsl = "ls -l";

      # cat replacement
      cat = "bat";

      # htop replacement
      htop = "btop";

      # confirm before overwriting something
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";

      # easier to read disk
      df = "df -h"; # human-readable sizes
      free = "free -m"; # show sizes in MB
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };

  programs.git = {
    enable = true;
    userName = "kputnins";
    userEmail = "kaspars.putnins19@gmail.com";
    extraConfig = {
      push = { autoSetupRemote = true; };
    };
  };


  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "micro";
    SUDO_EDITOR = "micro";

    QT_QPA_PLATFORM = "wayland";

    YSU_MESSAGE_POSITION = "after"; # ZSH alias reminder
    # To skip some folders with fzf - don't forget to install fd
    FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
  };

  # Gnome dconf settings
  dconf = {
    enable = true;
  };
  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-uri = "";
      picture-uri-dark = "";
      primary-color = "black";
      secondary-color = "black";
    };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark"; # Dark theme
      gtk-theme = "adw-gtk3-dark"; # Dark theme for legacy gdk apps
    };
    "org/gnome/desktop/peripherals".numlock-state = true;
    "org/gnome/desktop/privacy" = {
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };
    "org/gnome/desktop/screensaver".lock-enabled = false;
    "org/gnome/nautilus/preferences".default-folder-viewer = "list-view";
    "org/gnome/nautilus/list-view" = {
      use-tree-view = true;
      default-zoom-level = "small";
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-last-coordinat3es = "(56.942499772841622, 24.097799999999999)";
      night-light-temperature = 3700;
    };
    "org/gnome/shell/weather" = {
      autonatic-location = true;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "tactile@lundal.io"
        "appindicatorsupport@rgcjonas.gmail.com"
        "clipboard-indicator@tudmotu.com"
        "extension-list@tu.berry"
        "lockkeys@vaina.lt"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "solaar-extension@sidevesh"
        "undecorate@sun.wxg@gmail.com"
        "Vitals@CoreCoding.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "google-chrome.desktop"
        "codium.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
      show-hidden = true;
      view-type = "list";
    };


    # "org/gnome/desktop/wm/keybindings" = {
    #   switch-to-workspace-left = [ "<Super>a" ];
    #   switch-to-workspace-right = [ "<Super>d" ];
    #   move-to-workspace-left = [ "<Shift><Super>a" ];
    #   move-to-workspace-right = [ "<Shift><Super>d" ];
    #   switch-to-workspace-1 = [ "<Super>1" ];
    #   switch-to-workspace-2 = [ "<Super>2" ];
    #   switch-to-workspace-3 = [ "<Super>3" ];
    #   switch-to-workspace-4 = [ "<Super>4" ];
    #   switch-input-source = [ "<Shift><Alt>" ];
    #   switch-input-source-backward = mkEmptyArray type.string;
    #   activate-window-menu = [ "Menu" ];
    #   close = [ "<Shift><Super>w" ];
    #   maximize = [ "<Super>f" ];
    #   toggle-fullscreen = [ "<Shift><Super>f" ];
    # };

    # "org/gnome/shell/keybindings" = {
    #   # Following binds are replaced by the ones above.
    #   toggle-application-view = mkEmptyArray type.string;
    #   switch-to-application-1 = mkEmptyArray type.string;
    #   switch-to-application-2 = mkEmptyArray type.string;
    #   switch-to-application-3 = mkEmptyArray type.string;
    #   switch-to-application-4 = mkEmptyArray type.string;

    #   show-screen-recording-ui = mkEmptyArray type.string;
    #   screenshot = mkEmptyArray type.string;
    #   show-screenshot-ui = [ "<Shift><Super>s" ];
    #   screenshot-window = mkEmptyArray type.string;
    # };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
