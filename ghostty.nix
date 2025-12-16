{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.ghostty.packages.${pkgs.system}.default
  ];
}
