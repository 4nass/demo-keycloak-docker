# ttyd
Please specify your own **client secret** in keycloak-gatekeeper.conf.
```yaml
# is the url for retrieve the OpenID configuration - normally the <server>/auth/realm/<realm_name>
discovery-url: https://auth.docker.local/auth/realms/development
# skip tls verify
skip-openid-provider-tls-verify: true
# the client id for the 'client' application
client-id: ttyd
# the secret associated to the 'client' application
client-secret: fae836e6-e3aa-4436-b951-3c943b4c5811
# the interface definition you wish the proxy to listen, all interfaces is specified as ':<port>', unix sockets as unix://<REL_PATH>|</ABS PATH>
listen: :3000
# whether to enable refresh tokens
enable-refresh-tokens: true
# the location of a certificate you wish the proxy to use for TLS support
tls-cert:
# the location of a private key for TLS
tls-private-key:
# the redirection url, essentially the site url, note: /oauth/callback is added at the end
redirection-url: https://ttyd.docker.local
# the encryption key used to encode the session state
encryption-key: vGcLt8ZUdPX5fXhtLZaPHZkGWHZrT6aa
# the upstream endpoint which we should proxy request
upstream-url: http://ttyd:7681/
# additional scopes to add to add to the default (openid+email+profile)
scopes:
#- vpn-user
# a collection of resource i.e. urls that you wish to protect
# ======================================================================
resources:
- uri: /*
  methods:
  - GET 

- uri: /admin/*
  methods:
  - GET
  roles:
  - openvpn:vpn-user
  - openvpn:prod-vpn

- uri: /admin/*
  methods:
  - GET
  roles:
  - openvpn:vpn-user
  - openvpn:commons-prod-vpn

```
