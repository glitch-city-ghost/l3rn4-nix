# ⚠️ Security Notice & Design Decisions

This repository is designed for **single-user, trusted-network WSL2 environments** running autonomous AI agents (the "Hydra" architecture). 

To ensure the AI agents can function properly, this configuration makes **intentional security trade-offs**. Please review them carefully before deployment:

### 1. Docker Group Access (Root Equivalent)
The `nixos` user is added to the `docker` group. This is required so the OpenCode agent can manage Docker containers without password prompts. 
* **Risk:** Membership in the `docker` group is equivalent to root access on the host. Any process running as `nixos` can mount the host filesystem and escape containers.
* **Mitigation:** Only run trusted code. Do not use this configuration on multi-user systems.

### 2. Proxy LAN Exposure (`allow-lan: true` + `bind-address: "*"`)
The `mihomo` proxy binds to all network interfaces (`*:7890`) to allow Docker containers on the WSL2 bridge network to route their traffic through it.
* **Risk:** If your Windows Firewall is disabled or permissive, the proxy port `7890` may be accessible from your local network (LAN).
* **Mitigation:** Ensure your Windows Firewall blocks inbound connections on port `7890` from untrusted networks.

### 3. Missing Host Firewall (`iptables = false`)
Docker is configured with `iptables = false` to prevent conflicts with WSL2's `mirrored` networking mode. No `networking.firewall` rules are defined in NixOS.
* **Risk:** Ports exposed by Docker or other services are not automatically firewalled by NixOS.
* **Mitigation:** Manage your firewall rules on the Windows host side.

### 4. `CAP_DAC_OVERRIDE` in Mihomo
The `mihomo` systemd service runs with `CAP_DAC_OVERRIDE` to bypass file permissions when reading its merged configuration file from `/var/lib/private/mihomo/`.
* **Risk:** This capability bypasses all file permission checks.
* **Mitigation:** This is strictly confined by `ProtectSystem=strict` and `NoNewPrivileges`, meaning mihomo cannot write to system directories or escalate privileges.

### 5. Traefik uses the File Provider (No Docker API Access)
Traefik does **not** have access to the Docker socket (`/var/run/docker.sock`) and no longer uses `docker-socket-proxy` or the Docker provider. All routes are declared statically in `traefik-dynamic/routes.yaml` and loaded through the file provider.
* **Risk:** A new container does not become reachable until its router and service are added to `traefik-dynamic/routes.yaml`. There is no automatic Docker-label discovery.
* **Mitigation:** Docker API access is completely removed from Traefik. The socket proxy container is gone, so workloads on `traefik-net` cannot reach a read-only Docker API and inspect other containers. Traefik still runs with `no-new-privileges:true`.

---
*By using this configuration, you acknowledge these design decisions.*
