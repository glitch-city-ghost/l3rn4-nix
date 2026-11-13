{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    (writeShellScriptBin "check-mihomo" (builtins.readFile ../scripts/check-mihomo.sh))
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."fastfetch/config.jsonc".source = ../fastfetch.jsonc;
}
