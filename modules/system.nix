{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl wget jq openssl yq ripgrep fd bat eza fzf zoxide htop python3 nodejs
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nix-ld.enable = true;
}
