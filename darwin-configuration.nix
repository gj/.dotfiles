{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "ngrok"
  ];

  environment = {
    # darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

    loginShell = "${pkgs.zsh}/bin/zsh -l";

    shellAliases = {
      cat = "${pkgs.bat}/bin/bat";
      dotfiles = "cd ~/.dotfiles";
      hb = "${pkgs.hub}/bin/hub browse";
      l = "${pkgs.eza}/bin/eza -la --git";
      mkdir = "mkdir -p";
      path = "echo $PATH | tr -s ':' '\n'";
      reload = "source ~/.zshrc";
      tree = "${pkgs.eza}/bin/eza -a --git-ignore --tree --ignore-glob='node_modules|.git|.mypy_cache|.cache|__pycache__|.pytest_cache|target|venv|_static|_build|tmp|_api_docs' --color=always | less -R";
      vimrc = "${pkgs.vim-darwin}/bin/vim ~/.vimrc";
      work = "cd ~/work";
      zshrc = "${pkgs.vim-darwin}/bin/vim ~/.zshrc";
      "-- -" = "cd -";
      "python-me-pls" = "cp ~/work/oso/main/.envrc .";
      "code" = "code-insiders";

      # Oso
      dev = "cd ~/work/oso/dev";
      main = "cd ~/work/oso/main";
    };

    systemPackages = [
      pkgs.awscli2
      pkgs.aspell
      pkgs.aspellDicts.en
      pkgs.bat
      pkgs.cmake
      pkgs.coreutils
      pkgs.curl
      # pkgs.darwin.apple_sdk.frameworks.Security
      pkgs.direnv
      pkgs.enchant
      pkgs.eza
      pkgs.fd
      pkgs.fzf
      pkgs.gettext # for python
      pkgs.gh
      pkgs.git
      pkgs.gnugrep
      pkgs.gnumake
      pkgs.gnupg
      pkgs.htop
      pkgs.jq
      pkgs.ngrok
      pkgs.overmind
      pkgs.par
      pkgs.parallel
      pkgs.pv
      pkgs.pstree
      pkgs.readline82
      pkgs.ripgrep
      pkgs.shellcheck
      pkgs.sqlite
      pkgs.starship
      pkgs.vim-darwin
      pkgs.wget
      pkgs.xz # for installing Python via pyenv via ASDF
      pkgs.yq-go
    ];

    variables = {
      EDITOR = "vim";
      LANG = "en_US.UTF-8";
      SHELL = "${pkgs.zsh}/bin/zsh";
      PYENCHANT_LIBRARY_PATH = "${pkgs.enchant}/lib/libenchant-2.2.dylib";
    };
  };

  homebrew = {
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    enable = true;
    global = {
      brewfile = true;
      lockfiles = true;
    };
    brews = [ "opensearch" "pulumi/tap/pulumi" ];
    taps = [ "pulumi/tap" "homebrew/cask" ];

    casks = [ "maccy" ];
    caskArgs = {
      appdir = "~/Applications";
      require_sha = true;
    };
  };

  networking = {
    computerName = "work";
    hostName = "work";
  };

  nix = {
    package = pkgs.nixVersions.unstable;
    settings = {
      # extra-sandbox-paths = [ "/System/Library/Frameworks" "/System/Library/PrivateFrameworks" ];
      sandbox = true;
    };
  };

  programs = {
    zsh = {
      enable = true;  # default shell on catalina
      # enableCompletion = true;
      # enableBashCompletion = true;
      # enableFzfHistory = true;
      # enableSyntaxHighlighting = true;
      # promptInit = "autoload -Uz promptinit && promptinit";
    };

    tmux = {
      enable = true;
      # enableSensible = true;
      # enableMouse = true;
      # enableFzf = true;
      # enableVim = true;
      extraConfig = ''
        # Use Nix-managed zsh. # can't do this until tmux-status is in this shell
        # set-option -g default-shell "${pkgs.zsh}/bin/zsh"

        ${builtins.readFile "/Users/g/.tmux.conf"}
      '';
    };
  };

  services = {
    # lorri.enable = true;

    # Auto upgrade nix package and the daemon service.
    nix-daemon.enable = true;

    # postgresql = {
    #   enable = true;
    #   package = pkgs.postgresql;
    #   port = 5432;
    # };

    # redis = {
    #   enable = true;
    #   port = 6379;
    # };
  };

  system = {
    defaults = {
      alf = {
        globalstate = 2; # Block all incoming connections except those required
                         # for basic Internet services.
        stealthenabled = 1;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        expose-animation-duration = 0.0;
        launchanim = false;
        mineffect = "scale";
        mru-spaces = false; # Do not reorder Spaces based on most recent use.
        orientation = "right";
        showhidden = true;
        show-recents = false;
        static-only = true; # Show only open apps in the Dock.
        tilesize = 64;
      };

      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
      };

      # https://macos-defaults.com/misc/LSQuarantine.html
      # Won't work on Big Sur.
      LaunchServices.LSQuarantine = false;

      loginwindow = {
        SHOWFULLNAME = true;
        GuestEnabled = false;
        LoginwindowText = "Reward if found.";
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSTableViewDefaultSizeMode = 2;
        InitialKeyRepeat = 15; # 15 is normal
        KeyRepeat = 2; # 2 is normal
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.scaling" = 3.0;
        _HIHideMenuBar = true;
      };

      screencapture = {
        location = "/Users/g/Pictures";
        disable-shadow = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

      trackpad = {
        Clicking = true;
        # TrackpadThreeFingerDrag = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    stateVersion = 4; # Used for backwards compatibility.
  };
}
