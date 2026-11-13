{ config, lib, pkgs, ... }:

{
  # Подключаем наши кастомные модули
  imports = [
    ./modules/mihomo.nix
    ./modules/docker.nix
    ./modules/system.nix
    ./modules/wsl.nix
    ./modules/gc.nix
    ./modules/traefik.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
