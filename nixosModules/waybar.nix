{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    (_: _: { waybar_git = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar; })
  ];
  programs.waybar.enable = true;
  #programs.waybar.package = pkgs.waybar_git;
}
