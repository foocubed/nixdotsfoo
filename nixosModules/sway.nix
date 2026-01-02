{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable Sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      grim
      slurp
      mako
      wl-clipboard
      bemenu
      swaybg
      swaylock
      swayidle
    ];
  };
}
