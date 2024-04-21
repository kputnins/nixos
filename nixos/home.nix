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
    pkgs.showmethekey
    pkgs.librecad
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
      ];
    };

    shellAliases = {
      code = "codium";
      nix-update = "sudo nixos-rebuild switch --flake ~/.config/kp/nixos/#default";
      nix-clean = "nix-collect-garbage && sudo nixos-rebuild boot --flake ~/.config/kp/nixos/#default";
      nix-gen-list = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      nix-gen-clean = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d && nix-collect-garbage && sudo nixos-rebuild boot --flake ~/.config/kp/nixos/#default";

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
      ls = "eza --icons=always";
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

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhsWithPackages (ps: with ps; [
      # Rust
      rustup
      zlib
      # C++
      gdb
      gcc
      clang
      # python
      python3
    ]);
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Custom smplayer shortcut to wrapped smplayer
  home.file.".local/share/applications/smplayer.desktop" = {
    text = ''
      [Desktop Entry]
      Type=Application
      Name=SMPlayer
      GenericName=Media player
      X-GNOME-FullName=SMPlayer
      Comment=Video player
      Exec=smplayer %U
      TryExec=smplayer
      Icon=smplayer
      Terminal=false
      NoDisplay=false
      Categories=AudioVideo;Player;
      MimeType=application/ogg;application/x-ogg;audio/ogg;audio/vorbis;audio/x-vorbis;audio/x-vorbis+ogg;video/ogg;video/x-ogm;video/x-ogm+ogg;video/x-theora+ogg;video/x-theora;audio/x-speex;audio/opus;application/x-flac;audio/flac;audio/x-flac;audio/x-ms-asf;audio/x-ms-asx;audio/x-ms-wax;audio/x-ms-wma;video/x-ms-asf;video/x-ms-asf-plugin;video/x-ms-asx;video/x-ms-wm;video/x-ms-wmv;video/x-ms-wmx;video/x-ms-wvx;video/x-msvideo;audio/x-pn-windows-acm;video/divx;video/msvideo;video/vnd.divx;video/avi;video/x-avi;application/vnd.rn-realmedia;application/vnd.rn-realmedia-vbr;audio/vnd.rn-realaudio;audio/x-pn-realaudio;audio/x-pn-realaudio-plugin;audio/x-real-audio;audio/x-realaudio;video/vnd.rn-realvideo;audio/mpeg;audio/mpg;audio/mp1;audio/mp2;audio/mp3;audio/x-mp1;audio/x-mp2;audio/x-mp3;audio/x-mpeg;audio/x-mpg;video/mp2t;video/mpeg;video/mpeg-system;video/x-mpeg;video/x-mpeg2;video/x-mpeg-system;application/mpeg4-iod;application/mpeg4-muxcodetable;application/x-extension-m4a;application/x-extension-mp4;audio/aac;audio/m4a;audio/mp4;audio/x-m4a;audio/x-aac;video/mp4;video/mp4v-es;video/x-m4v;application/x-quicktime-media-link;application/x-quicktimeplayer;video/quicktime;application/x-matroska;audio/x-matroska;video/x-matroska;video/webm;audio/webm;audio/3gpp;audio/3gpp2;audio/AMR;audio/AMR-WB;video/3gp;video/3gpp;video/3gpp2;x-scheme-handler/mms;x-scheme-handler/mmsh;x-scheme-handler/rtsp;x-scheme-handler/rtp;x-scheme-handler/rtmp;x-scheme-handler/icy;x-scheme-handler/icyx;application/x-cd-image;x-content/video-vcd;x-content/video-svcd;x-content/video-dvd;x-content/audio-cdda;x-content/audio-player;application/ram;application/xspf+xml;audio/mpegurl;audio/x-mpegurl;audio/scpls;audio/x-scpls;text/google-video-pointer;text/x-google-video-pointer;video/vnd.mpegurl;application/vnd.apple.mpegurl;application/vnd.ms-asf;application/vnd.ms-wpl;application/sdp;audio/dv;video/dv;audio/x-aiff;audio/x-pn-aiff;video/x-anim;video/x-nsv;video/fli;video/flv;video/x-flc;video/x-fli;video/x-flv;audio/wav;audio/x-pn-au;audio/x-pn-wav;audio/x-wav;audio/x-adpcm;audio/ac3;audio/eac3;audio/vnd.dts;audio/vnd.dts.hd;audio/vnd.dolby.heaac.1;audio/vnd.dolby.heaac.2;audio/vnd.dolby.mlp;audio/basic;audio/midi;audio/x-ape;audio/x-gsm;audio/x-musepack;audio/x-tta;audio/x-wavpack;audio/x-shorten;application/x-shockwave-flash;application/x-flash-video;misc/ultravox;image/vnd.rn-realpix;audio/x-it;audio/x-mod;audio/x-s3m;audio/x-xm;application/mxf;
      X-KDE-Protocols=ftp,http,https,mms,rtmp,rtsp,sftp,smb
      Keywords=Player;Capture;DVD;Audio;Video;Server;Broadcast;
    '';
  };

  # Solaar rule for MX MAster S3 thumb button
  home.file.".config/solaar/rules.yaml" = {
    text = ''
      %YAML 1.3
      ---
      - Key: [Mouse Gesture Button, pressed]
      - KeyPress:
        - Super_L
        - click
      ...
    '';
  };

  # To enable MS extension marketplace in VS Codium
  # https://github.com/VSCodium/vscodium/blob/master/docs/index.md#how-to-use-the-open-vsx-registry
  home.file.".config/VSCodium/product.json" = {
    text = ''
      {
        "extensionsGallery": {
          "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
          "itemUrl": "https://marketplace.visualstudio.com/items",
          "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
          "controlUrl": ""
        }
      }
    '';
  };

  # Flameshot options
  home.file.".config/flameshot/flameshot.conf" = {
    text = ''
      [General]
      buttons=@Variant(\0\0\0\x7f\0\0\0\vQList<int>\0\0\0\0\x16\0\0\0\0\0\0\0\x1\0\0\0\x2\0\0\0\x3\0\0\0\x4\0\0\0\x5\0\0\0\x6\0\0\0\x12\0\0\0\xf\0\0\0\x16\0\0\0\x13\0\0\0\a\0\0\0\b\0\0\0\t\0\0\0\x10\0\0\0\n\0\0\0\v\0\0\0\x17\0\0\0\xe\0\0\0\f\0\0\0\x14\0\0\0\x15)
      contrastOpacity=188
      drawThickness=3
      saveAsFileExtension=jpeg
      savePath=/home/kp/Pictures/Screenshots
      uiColor=#750097
      undoLimit=104
      uploadClientSecret=
      useJpgForClipboard=false
    '';
  };

  # Autostart solaar
  home.file.".config/autostart/solaar.desktop" = {
    source = pkgs.writeText "solaar.desktop" ''
      [Desktop Entry]
      Name=Solaar
      Comment=Logitech Unifying Receiver peripherals manager
      Comment[fr]=Gestionnaire de périphériques pour les récepteurs Logitech Unifying
      Comment[hr]=Upravitelj Logitechovih uređaja povezanih putem Unifying i Nano prijemnika
      Comment[ru]=Управление приёмником Logitech Unifying Receiver
      Comment[es]=Administrador de periféricos de Logitech Receptor Unifying
      Exec=solaar --window=hide
      Icon=solaar
      StartupNotify=true
      Terminal=false
      Type=Application
      Keywords=logitech;unifying;receiver;mouse;keyboard;
      Categories=Utility;GTK;
      #Categories=Utility;GTK;Settings;HardwareSettings;
      X-GNOME-UsesNotifications=true
    '';
  };

  home.sessionVariables = {
    EDITOR = "micro";
    SUDO_EDITOR = "micro";

    QT_QPA_PLATFORM = "wayland";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";

    YSU_MESSAGE_POSITION = "after"; # ZSH alias reminder
    # To skip some folders with fzf - don't forget to install fd
    FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";

    # VS Code on wayland
    NIXOS_OZONE_WL = "1";
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
    "org/gnome/desktop/wm/keybindings" = {
      move-to-monitor-left = [ ];
      move-to-monitor-right = [ ];
      move-to-monitor-up = [ ];
      move-to-monitor-down = [ ];
      switch-to-workspace-left = [ "<Super>Left" ];
      switch-to-workspace-right = [ "<Super>Right" ];
      move-to-workspace-left = [ "<Shift><Super>Left" ];
      move-to-workspace-right = [ "<Shift><Super>Right" ];
      close = [ "<Shift><Control>w" ];
    };
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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
