{ pkgs, inputs, system, ... }:

{
  environment.systemPackages = [
    inputs.zed.packages.${pkgs.system}.default
  ];
}
