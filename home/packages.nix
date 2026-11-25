{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
    (writeShellScriptBin "disk-usage" (builtins.readFile ./disk-usage.sh))
  ];

  fonts.fontconfig.enable = true;
}
