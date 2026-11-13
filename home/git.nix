{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "glitch-city-ghost";
        email = "43579195+glitch-city-ghost@users.noreply.github.com";
      };
      delta.navigate = true;
      delta.side-by-side = true;
      delta.line-numbers = true;
      delta.syntax-theme = "TwoDark";
      merge.conflictStyle = "diff3";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
