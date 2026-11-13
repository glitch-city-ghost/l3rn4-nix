{ config, pkgs, ... }:

let
  vim-cyberpunk = pkgs.vimUtils.buildVimPlugin {
    name = "vim-cyberpunk";
    src = pkgs.fetchFromGitHub {
      owner = "glitch-city-ghost";
      repo = "vim-cyberpunk";
      rev = "2c009b8451732d8e9742fe354c134f6a34b41f92";
      hash = "sha256-AhwPJzH5xMR/2MG4VH5xxEL1yZj3fE3ET3abuBs7aOY=";
    };
    postInstall = ''
      mkdir -p $out/autoload/airline/themes
      cp -r $out/autoload/airline/* $out/autoload/airline/themes/ 2>/dev/null || true
    '';
  };
in
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-cyberpunk
      vim-airline
      vim-airline-themes
      nerdtree
    ];
    extraConfig = builtins.readFile ../vimrc;
  };
}
