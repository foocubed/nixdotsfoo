{config,pkgs,callPackage, ...}:
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "17gy35hys6zbc9g2pp48k0sicj4x4ysxr33m3vx9jf6dbmbbi5wx";
    }))
  ];
  services.emacs.package = pkgs.emacs-unstable-pgtk;
  services.emacs.enable = true;
}
