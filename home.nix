{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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
    # Adds the 'hello' command to your environment. It prints a friendly
    # "Hello, world!" when run.
    pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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

      update = "sudo nixos-rebuild switch --flake ~/nixos/#default";

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
      df = "df -h";     # human-readable sizes
      free = "free -m"; # show sizes in MB
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };

  programs.git = {
    enable = true;
    userName  = "kputnins";
    userEmail = "kaspars.putnins19@gmail.com";
    extraConfig = {
      push = { autoSetupRemote = true; };
    };
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kp/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR="micro";
    SUDO_EDITOR="micro";

    YSU_MESSAGE_POSITION="after"; # ZSH alias reminder
    FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"; # To skip folders with fzf
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
