{ config, pkgs, ... }:

{
  imports = [
    ./home/git.nix
    ./home/zsh.nix
    ./home/vim.nix
    ./home/packages.nix
  ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";
}
