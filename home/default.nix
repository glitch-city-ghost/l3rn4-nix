{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./fastfetch.nix
    ./git.nix
    ./zsh.nix
    ./vim
    ./btop
    ../dash
  ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";
}
