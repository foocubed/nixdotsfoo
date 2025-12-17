{
  pkgs,
  self,
  ...
}:
{
  nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];
  services.emacs.package = pkgs.emacs-unstable-pgtk;
  services.emacs.enable = true;
}
