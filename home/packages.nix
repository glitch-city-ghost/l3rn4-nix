{ config, pkgs, ... }:

let
  dashUnwrapped = pkgs.writeShellScriptBin "dash-unwrapped" (builtins.readFile ../scripts/dash);

  # Bake in the packaged dash.conf, but let a user copy in
  # ~/.config/l3rn4/dash.conf take precedence at runtime.
  dashWrapper = pkgs.writeShellScriptBin "dash" ''
    export DASH_DEFAULT_CONFIG="''${DASH_DEFAULT_CONFIG:-${../dash.conf}}"
    exec ${dashUnwrapped}/bin/dash-unwrapped "$@"
  '';
in
{
  home.packages = with pkgs; [
    fastfetch
    tmux
    (writeShellScriptBin "check-mihomo" (builtins.readFile ../scripts/check-mihomo.sh))
    dashWrapper
    (writeShellScriptBin "proxy-status" (builtins.readFile ../scripts/proxy-status))
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."fastfetch/config.jsonc".source =
    ../themes/cyberpunk/fastfetch/config.jsonc;
}
