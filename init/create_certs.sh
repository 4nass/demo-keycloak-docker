mkcert -install
mkcert -cert-file certs/local-cert.pem -key-file certs/lacal-key.pem "docker.local" "*.docker.local" "domain.local" "*.domain.local"
