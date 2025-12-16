{ pkgs,inputs,...}:

{
imports = [ inputs.niri.nixosModules.niri];
niri-flake.cache.enable = true;
programs.niri.enable = true;
nixpkgs.overlays = [ inputs.niri.overlays.niri ];
programs.niri.package = pkgs.niri-unstable;
}
