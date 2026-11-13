{ config, lib, pkgs, ... }:

{
  # Ensure Docker is enabled (imported from docker.nix)
  # virtualisation.docker.enable = true;

  # Explicitly set the OCI container backend to Docker
  virtualisation.oci-containers.backend = "docker";

  # Create the traefik-net Docker network at boot via a systemd oneshot service
  systemd.services.traefik-network = {
    description = "Create Docker network 'traefik-net' for Traefik and proxied services";
    wantedBy = [ "multi-user.target" ];
    before = [ "docker-socket-proxy.service" "traefik.service" ];
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.docker}/bin/docker network create --driver bridge traefik-net || true";
      ExecStop = "";
    };
  };

  # Docker Socket Proxy - restricts Traefik's access to Docker API
  virtualisation.oci-containers.containers.docker-socket-proxy = {
    image = "tecnativa/docker-socket-proxy:latest";
    network = "traefik-net";
    environment = {
      CONTAINERS = "1";
      SERVICES = "1";
      NETWORKS = "1";
      # Explicitly disable all other endpoints for security
      TASKS = "0";
      IMAGES = "0";
      VOLUMES = "0";
      BUILDS = "0";
      CONFIGS = "0";
      SECRETS = "0";
      NODES = "0";
      PLUGINS = "0";
    };
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    extraOptions = [ "--security-opt=no-new-privileges:true" "--user=root" ]; # Required to read docker.sock
    dependsOn = [ "traefik-network" ];
  };

  # Traefik Reverse Proxy
  virtualisation.oci-containers.containers.traefik = {
    image = "traefik:v3.7";
    network = "traefik-net";
    ports = [
      "127.0.0.1:80:80"
      "127.0.0.1:8080:8080"
    ];
    cmd = [
      "--providers.docker=true"
      "--providers.docker.endpoint=http://docker-socket-proxy:2375"
      "--providers.docker.exposedByDefault=false"
      "--providers.docker.network=traefik-net"
      "--api.insecure=true"
      "--entrypoints.web.address=:80"
      "--log.level=INFO"
    ];
    extraOptions = [ "--security-opt=no-new-privileges:true" ];
    dependsOn = [ "traefik-network" "docker-socket-proxy" ];
  };
}