{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
  ];

  xdg.configFile = {
    "btop/btop.conf".source = ./btop.conf;
    "btop/themes/cyberpunk.theme".source =
      ../../theme/generated/cyberpunk/btop/cyberpunk.theme;
  };
}
