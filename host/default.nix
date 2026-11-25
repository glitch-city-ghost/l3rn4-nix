{ config, lib, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./docker.nix
    ./gc.nix
    ./wsl.nix
    ../mihomo
    ../traefik
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.nixos = import ../home;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
