# Traefik
Traefik v2 works with a static and dynamic configuration system. The static configuration is loaded at startup, and any change in this configuration will require a reboot of Traefik. The dynamic configuration can be changed on the fly.
## Static configuration

```yaml
# traefik/traefik.yml
global:
  sendAnonymousUsage: false

api:
  dashboard: true
  insecure: true

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    watch: true
    exposedByDefault: false

  file:
    filename: /etc/traefik/config.yml
    watch: true

log:
  level: INFO
  format: common

entryPoints:
  http:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: https
          scheme: https
  https:
    address: ":443"
```
As you can see, we specify docker provider and the dynamic configuration. We also force a redirection of HTTP over HTTPS.

## Dynamic configuration


```yaml
# traefik/config.yml
http:
  routers:
    traefik:
      rule: "Host(`traefik.docker.local`)"
      service: "api@internal"
      tls:
        domains:
          - main: "docker.local"
            sans:
              - "*.docker.local"
          - main: "domain.local"
            sans:
              - "*.domain.local"

tls:
  certificates:
    - certFile: "/etc/certs/local-cert.pem"
      keyFile: "/etc/certs/local-key.pem"
```
Here we specify the certificate to be used for SSL, and we add the configuration of a router named "traefik". This will avoid having to do it in the docker-compose.yml.
