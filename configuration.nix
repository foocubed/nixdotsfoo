{
  pkgs,
  config,
  nixpkgs-stable,
  nixpkgs-unstable,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./extraconfig.nix
    ./packages.nix
    ./emacs.nix
    ./disk-config.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.users.foo = {
    isNormalUser = true;
    description = "foo";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
      "docker"
    ];
    #initialPassword="4321";
    packages = with pkgs; [
      #  thunderbird
    ];
  };
  nixpkgs.config.allowUnfree = true;
  networking.hostId = "a5ecb278";
  system.stateVersion = "24.11";
 }
