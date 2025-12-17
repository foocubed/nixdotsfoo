{
  pkgs,
  inputs,
  ...
}:
{
  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];
  services.emacs.package = pkgs.emacs-unstable-pgtk;
  services.emacs.enable = true;
}
