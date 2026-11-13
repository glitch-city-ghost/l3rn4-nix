{ config, pkgs, ... }:

{
  # Включаем автоматическую сборку мусора
  nix.gc = {
    automatic = true;
    dates = "weekly"; # Запускать раз в неделю
    options = "--delete-older-than 7d --keep-max 5"; # Удалять всё старше 7 дней
  };

  # Настраиваем оптимизацию Nix Store (дедупликация)
  nix.settings.auto-optimise-store = true;
}
