{ pkgs,inputs,...}:

{
environment.systemPackages = [
            ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
          ];
}
