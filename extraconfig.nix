{ config, pkgs, ... }:
{
  networking.hostName = "foo"; # Define your hostname.
  networking.nftables.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    8384
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    22000
    21027
  ];
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "foo" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  services.flatpak.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  virtualisation.containers.enable = true;
  virtualisation = {
  podman = {
    enable = true;
    # Create a `docker` alias for podman, to use it as a drop-in replacement
    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };
};
  services = {
    syncthing = {
      enable = true;
      group = "users";
      user = "foo";
      dataDir = "/home/foo/Documents"; # Default folder for new synced folders
      configDir = "/home/foo/Documents/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  }; 
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  services.zfs.autoScrub.enable = true;
  services.zfs.autoSnapshot.enable = true;
  services.zfs.trim.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
