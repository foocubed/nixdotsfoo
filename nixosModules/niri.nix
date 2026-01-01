{
  pkgs,
  inputs,
  ...
}:

let
  # Import the unstable channel with system + config
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.system;
    config.allowUnfree = true;
  };
in
{
  # Bring in niri module from the flake input
  imports = [
    inputs.niri.nixosModules.niri
  ];

  # niri settings
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };

  # overlay
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  # Ozone flags for Wayland (Chrome/Discord/Electron)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Packages from unstable
  environment.systemPackages = with unstable; [
    wl-clipboard
    wayland-utils
    libsecret
    xwayland-satellite
  ];
}
