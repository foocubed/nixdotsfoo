{
  pkgs,
  inputs,
  ...
}:
let
  unstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = [ (import ./overlays/nnn.nix) ];
  };
  stable = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  home.username = "foo";
  home.homeDirectory = "/home/foo";
  home.sessionVariables = {
    NNN_FIFO = /tmp/nnn.fifo;
    NNN_COLORS = "12345678";
    NNN_FCOLORS = "c1e2272e006033f7c6d6abc4";
  };
  home.file.".dict".source = "${pkgs.hunspellDicts.en_US}/share/hunspell/en_US.dic";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  xdg.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "foocubed";
        email = "foocubed@gmail.com";
      };
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.zellij = {
    enable = true;
    settings = {
      theme = "iceberg-light";
      default_shell = "fish";
      rounded_corners = "true";
    };
  };
  #Enable Kitty
  programs.kitty = {
    package = unstable.kitty;
    enable = true;
    font = {
      name = "FantasqueSansM Nerd Font Bold";
      size = 16;
    };
    shellIntegration.enableFishIntegration = true;
    settings = {
      allow_remote_control = "yes";
      listen_on = "unix:@mykitty";
      enabled_layouts = "splits";
      window_padding_width = 50;
      shell = "fish";
      sync_to_monitor = "yes";
    };
    themeFile = "Modus_Operandi_Tinted";
  };
  programs.fish = {
    enable = true;
    package = unstable.fish;
    plugins = [
      {
        name = "fzf-fish";
        src = unstable.fishPlugins.fzf-fish;
      }
      {
        name = "fishplugin-autopair";
        src = unstable.fishPlugins.autopair;
      }
    ];
    generateCompletions = true;
    shellInit = ''
      		source ~/NixDotsFoo/fish/functions/n.fish
        		  '';
  };
  programs.zoxide = {
    enable = true;
    package = unstable.zoxide;
    enableFishIntegration = true;
  };
  programs.mcfly = {
    enable = true;
    #	package = unstable.mcfly;
    enableFishIntegration = true;
    fzf.enable = true;
  };
  programs.starship = {
    enable = true;
    package = unstable.starship;
    enableFishIntegration = true;
  };
  programs.lsd = {
    enable = true;
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = [
          # Put UUIDs of extensions that you want to enable here.
          # If the extension you want to enable is packaged in nixpkgs,
          # you can easily get its UUID by accessing its extensionUuid
          # field (look at the following example).
          pkgs.gnomeExtensions.accent-directories.extensionUuid
          #pkgs.gnomeExtensions.blur-my-shell.extensionUuid
          pkgs.gnomeExtensions.just-perfection.extensionUuid
          pkgs.gnomeExtensions.luminus-desktop.extensionUuid
        ];
      };
      "org/gnome/desktop/interface" = {
        font-name = "Inter 11";
        monospace-font-name = "CaskaydiaCove Nerd Font Mono 10";
        #icon-theme = "MoreWaita";
      };
      "org/gnome/mutter" = {
        edge-tiling = true;
        dynamic-workspaces = true;
      };
    };
  };
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  programs = {
    nnn = {
      package = unstable.nnn;
      enable = true;
      plugins.src =
        (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v5.0";
          sha256 = "sha256-HShHSjqD0zeE1/St1Y2dUeHfac6HQnPFfjmFvSuEXUA=";
        })
        + "/plugins";
      plugins.mappings = {
        j = "autojump";
        p = "preview-tui";
      };
    };
  };
  programs.television.enable = true;
  programs.television.package = unstable.television;
  programs.television.enableFishIntegration = true;

  programs.skim.enable = true;
  programs.skim.package = unstable.skim;
  programs.skim.enableFishIntegration = true;

  programs.eza.enable = true;
  programs.eza.icons = "always";
  programs.eza.package = unstable.eza;
  programs.eza.enableFishIntegration = true;
  programs.eza.extraOptions = [
    "--hyperlink"
    "--colour=always"
    "--group-directories-first"
  ];
  programs.helix.enable = true;
  programs.helix.package = unstable.helix;
  programs.helix.settings = {
    theme = "monokai_soda";
  };
}
