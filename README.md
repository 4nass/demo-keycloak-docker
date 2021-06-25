# Keycloak on Docker Workshop

Keycloak implementation in Docker envirenment with Demo Wordpress blog and kali ttyd.

## Project Focus:

Keycloak is an open source Identity and Access Management solution aimed at modern applications and services.

This project shows how to add Keycloak authentication to any web service with a builtin authentication layer (blog) or not (ttyd).

I run all my docker services behind traefik that receives requests on behalf of your system and finds out which components are responsible for handling them. 

PostgreSQL database used to persist Keycloak data.

MySQL database is required by Wordpress to store and retrieve all of its data, including article content, user profiles, and other custom plugins.

## Requirements:

- Docker

- Docker-compose

- [mkcert](https://github.com/FiloSottile/mkcert)

- IBM Security Verify Tenant

- IBM Verify Mobile Application 

## Getting Started:

Adding the services hostnames in /etc/hosts:

```console
127.0.0.1       traefik.docker.local
127.0.0.1       auth.docker.local
127.0.0.1       wordpress.docker.local
127.0.0.1       ttyd.docker.local
```

Docker network creation:

```console
user@docker:~$ cd /path/to/repo.git
user@docker:~$ cat ./init/create_network.sh
docker network create transit_idp
docker network create transit_ttyd
docker network create transit_wp
user@docker:~$ ./init/create_network.sh
```

Generate local certificates for Traefik using mkcert :

```console
user@docker:~$ cd /path/to/repo.git
# If it's the firt install of mkcert, run
user@docker:~$ mkcert -install
# Generate certificate for domain "docker.local", "domain.local" and their sub-domains
user@docker:~$ mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem "docker.local" "*.docker.local" "domain.local" "*.domain.local"

```

## Quickstart:

```console
user@docker:~$ docker-compose up -d
user@docker:~$ docker-compose logs -f
```

## User interface:

- Reverse proxy: Traefik 

    ![Alt text](https://github.com/AnassChahbouni/DockerKeycloakWorkshop/blob/master/images/traefik.png?raw=true "Traefik")

- Auth: Keycloak + Postgres 

    ![Alt text](https://github.com/AnassChahbouni/DockerKeycloakWorkshop/blob/master/images/keycloak1.png?raw=true "Keycloak")
    ![Alt text](https://github.com/AnassChahbouni/DockerKeycloakWorkshop/blob/master/images/keycloak2.png?raw=true "Keycloak")

- App1: Wordpress + MySQL a demo Wordpress blog (SAML) 
  
  ![Alt text](https://github.com/AnassChahbouni/DockerKeycloakWorkshop/blob/master/images/wordpress.png?raw=true "Wordpress")

- App2: Kali-ttyd is a tool Kali terminal shared over the web (OIDC) 
  
  ![Alt text](https://github.com/AnassChahbouni/DockerKeycloakWorkshop/blob/master/images/ttyd.png?raw=true "ttyd")

- App3: whoami Go based image to return info about the host
  
  ![Alt text](https://github.com/AnassChahbouni/DockerKeycloakWorkshop/blob/master/images/whoami.png?raw=true "Whoami")
  
## Cleaning up:
  
  Once you're finished playing around with this project, you can delete it and all the resources associated it by running:
  
  ```console
  user@docker:~$ docker-compose down --volumes
  ```

## Help and Documentation:

- [Keycloak Documentation](https://www.keycloak.org/documentation.html)
- [Keycloak Proxy Documentation](https://www.keycloak.org/docs/latest/securing_apps/#_keycloak_generic_adapter)
- [Traefik Documentation](https://doc.traefik.io/traefik/)
- [Wordpress Documentation](https://fr.wordpress.com/)
- [Ttyd Documentation](https://tsl0922.github.io/ttyd)


Wordpress Plugin installed for SAML workflow:

https://plugins.miniorange.com/saml-single-sign-on-sso-wordpress-using-jboss-keycloak

---
