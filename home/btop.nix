{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
  ];

  xdg.configFile = {
    "btop/btop.conf".source = ../btop/btop.conf;
    "btop/themes/cyberpunk.theme".source =
      ../themes/cyberpunk/btop/cyberpunk.theme;
  };
}
