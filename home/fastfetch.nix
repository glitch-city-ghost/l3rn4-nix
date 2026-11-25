{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
  ];

  xdg.configFile."fastfetch/config.jsonc".source =
    ../theme/generated/cyberpunk/fastfetch/config.jsonc;
}
