{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    tmux
    (writeShellScriptBin "check-mihomo" (builtins.readFile ../scripts/check-mihomo.sh))
    (writeShellScriptBin "dash" (builtins.readFile ../scripts/dash))
    (writeShellScriptBin "proxy-status" (builtins.readFile ../scripts/proxy-status))
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."fastfetch/config.jsonc".source = ../fastfetch.jsonc;
}
