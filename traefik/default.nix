{ config, lib, pkgs, ... }:

{
  # Explicitly set the OCI container backend to Docker
  virtualisation.oci-containers.backend = "docker";

  # Create the traefik-net Docker network at boot via a systemd oneshot service
  systemd.services.traefik-network = {
    description = "Create Docker network 'traefik-net' for Traefik and proxied services";
    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "-${pkgs.docker}/bin/docker network create --driver bridge traefik-net";
      ExecStop = "";
    };
  };

  # Traefik Reverse Proxy
  #
  # Traefik uses the file provider only. It does not read the Docker API and
  # therefore does not need access to /var/run/docker.sock or a socket proxy.
  # Routes are declared in traefik/dynamic/routes.yaml.
  virtualisation.oci-containers.containers.traefik = {
    image = "traefik:v3.7";
    ports = [
      "127.0.0.1:80:80"
      "127.0.0.1:8080:8080"
    ];
    cmd = [
      "--api.insecure=true"
      "--entrypoints.web.address=:80"
      "--log.level=INFO"
      # File provider: static routes for hydr4 and mihomo
      "--providers.file.directory=/etc/traefik/dynamic"
      "--providers.file.watch=true"
    ];
    extraOptions = [
      "--network=traefik-net"
      "--security-opt=no-new-privileges:true"
      "--add-host=host.docker.internal:host-gateway"
    ];
    # Монтируем папку с нашими yaml-файлами
    volumes = [
      "/home/nixos/l3rn4-nix/traefik/dynamic:/etc/traefik/dynamic:ro"
    ];
  };

  # Guarantee Traefik starts after the network is created
  systemd.services."docker-traefik".after = [ "traefik-network.service" ];
  systemd.services."docker-traefik".requires = [ "traefik-network.service" ];
}

