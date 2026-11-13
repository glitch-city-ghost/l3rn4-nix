{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = if (builtins.getEnv "GIT_USER_NAME" == "") then "user" else (builtins.getEnv "GIT_USER_NAME");
        email = if (builtins.getEnv "GIT_USER_EMAIL" == "") then "user@localhost" else (builtins.getEnv "GIT_USER_EMAIL");
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
