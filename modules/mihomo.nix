{ config, lib, pkgs, ... }:

{
  services.mihomo = {
    enable = true;
    configFile = ../mihomo-config.yaml;
  };

  systemd.services.mihomo = {
    # Ждем, пока Docker создаст мост docker0 (172.17.0.1)
    after = [ "docker.service" ];
    requires = [ "docker.service" ]; # На всякий случай, чтобы mihomo не стартовал без Docker
    
    serviceConfig = {
      LoadCredential = lib.mkForce "config.yaml:/var/lib/private/mihomo/config.yaml";
      ProtectHome = lib.mkForce true;
      ProtectSystem = lib.mkForce "strict";
      PrivateTmp = lib.mkForce true;
      NoNewPrivileges = lib.mkForce true;
      CapabilityBoundingSet = lib.mkForce [ "CAP_NET_BIND_SERVICE" "CAP_DAC_OVERRIDE" "CAP_NET_ADMIN" ]; 
      RestrictAddressFamilies = lib.mkForce [ "AF_INET" "AF_INET6" "AF_UNIX" "AF_NETLINK" ];
    };
  };

  system.activationScripts.copyMihomoConfig =
    lib.strings.replaceStrings
      [ "@PUBLIC_CONFIG@" "@YQ@" ]
      [ "${../mihomo-config.yaml}" "${pkgs.yq-go}/bin/yq" ]
      (builtins.readFile ../scripts/copy-mihomo);
}
