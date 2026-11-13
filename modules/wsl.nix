{ config, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # Настройки оболочки на системном уровне
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
}
