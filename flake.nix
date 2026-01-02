{
  description = "foo's NixOS Flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake";
    waybar.url = "github:Alexays/Waybar/master";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    ghostty.url = "github:ghostty-org/ghostty";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    deploy-rs.url = "github:serokell/deploy-rs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs-stable,
      home-manager,
      disko,
      niri,
      waybar,
      ghostty,
      wezterm,
      emacs-overlay,
      deploy-rs,
      hyprland,
      ...
    }@inputs:
    {
      nixosConfigurations.foo = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/foo/configuration.nix
          ./nixosModules
          {
            nix.settings = {
              trusted-users = [ "foo" ];
              substituters = [
                "https://cache.nixos.org"
                "https://nix-community.cachix.org"
                "https://niri.cachix.org"
                "https://ghostty.cachix.org"
                "https://wezterm.cachix.org"
                "https://hyprland.cachix.org"
              ];

              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
                "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
                "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
              ];
            };
          }
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.foo = {
              imports = [ ./home.nix ];
            };
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
      nixosConfigurations.xenos = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/xenos/configuration.nix
          ./nixosModules
          {
            nix.settings = {
              trusted-users = [ "foo" ];
              substituters = [
                "https://cache.nixos.org"
                "https://nix-community.cachix.org"
                "https://niri.cachix.org"
                "https://ghostty.cachix.org"
                "https://wezterm.cachix.org"
              ];

              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
                "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
                "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
              ];
            };
          }
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.foo = {
              imports = [ ./home.nix ];
            };
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

    };
}
