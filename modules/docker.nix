{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly"; # Можно "daily", если Docker очень активен
      flags = [ "--all" ]; # Удаляем образы, тома и кэш сборки
    };
    daemon.settings = {
      # Отключаем управление iptables в Docker, чтобы избежать конфликта с mirrored
      iptables = false;
      # Оставляем userland-proxy для проброса портов
      userland-proxy = true;
    };
  };

  # Даем пользователю nixos права на запуск докера
  users.users.nixos.extraGroups = [ "docker" ];
}
