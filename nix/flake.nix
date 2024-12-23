{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
          pkgs.alacritty
          pkgs.mkalias
          pkgs.neovim
          pkgs.obsidian
          pkgs.tmux
          pkgs.zoxide
          pkgs.fzf
          pkgs.github
          pkgs.ripgrep
          pkgs.rectangle
          pkgs.alttab
        ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
          "pyenv"
          "pyenv-virtualenv"
        ];
        casks = [
          "firefox"
          "iina"
          "google-chrome"
          "1password"
          "alfred"
          "docker"
          "postman"
          "logi-options+"
          "input-source-pro"
          "stow"
        ];
        masApps = {
          "Xcode" = 497799835;
          "iBar" = 6443843900;
        };

        # To cleanup all applications which are installed via brew
        # but not in the above list
        onActivation.cleanup = "zap";
        # Upgrade packages installed via homebrew
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      # Add GUI applications sim link for spotlight to search
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      # Mac system settings
      system.defaults = {
        dock = {
          autohide = true;
          largesize = 128;
          magnification = true;
          persistent-apps = [
            "/Applications/Google Chrome.app"
            "/Applications/Firefox.app"
            "${pkgs.alacritty}/Applications/Alacritty.app"
          ];
          show-recents = false;
          wvous-br-corner = "Start Screen Saver";
        };
        finder = {
          FXPreferredViewStyle = "clmv";
          NewWindowTarget = "Home";
          ShowPathbar = true;
        };
        trackpad = {
          Clicking = true;
          TrackpadThreeFingerDrag = true;
        };
        NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "joshuacao";

            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
