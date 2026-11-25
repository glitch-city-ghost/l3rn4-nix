{ config, pkgs, ... }:

let
  dashUnwrapped = pkgs.writeShellScriptBin "dash-unwrapped" (builtins.readFile ./dash);

  # Bake in the packaged dash.conf, but let a user copy in
  # ~/.config/l3rn4/dash.conf take precedence at runtime.
  dashWrapper = pkgs.writeShellScriptBin "dash" ''
    export DASH_DEFAULT_CONFIG="''${DASH_DEFAULT_CONFIG:-${./dash.conf}}"
    exec ${dashUnwrapped}/bin/dash-unwrapped "$@"
  '';
in
{
  home.packages = [
    dashWrapper
    (pkgs.writeShellScriptBin "proxy-status" (builtins.readFile ./proxy-status))
    (pkgs.writeShellScriptBin "check-mihomo" (builtins.readFile ./check-mihomo.sh))
  ];
}
