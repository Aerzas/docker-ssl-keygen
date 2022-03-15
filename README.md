# SSL Keygen

Minimalist helper docker container to generate self-signed certificates.

Docker Hub image: [https://hub.docker.com/r/aerzas/ssl-keygen](https://hub.docker.com/r/aerzas/ssl-keygen)

## Usage example

The container should be mounted with the current user to avoid permission issues.

```sh
mkdir -p /tmp/certificates;
docker run \
    --rm \
    -u $(id -u) \
    -v /tmp/certificates:/certificates \
    -e OPENSSL_CERTIFICATE_SUBJECT_COUNTRY=CH \
    -e OPENSSL_CERTIFICATE_SUBJECT_STATE=FR \
    -e OPENSSL_CERTIFICATE_SUBJECT_LOCATION=Fribourg \
    -e OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION=Docker \
    -e OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION_UNIT=Aerzas \
    -e SITE_DOMAIN=docker.test \
    aerzas/ssl-keygen:latest;
```

## Environment Variables

| Variable                                        | Default Value       |
|-------------------------------------------------|---------------------|
| `OPENSSL_CERTIFICATE_EXPIRATION`                | `825`               |
| `OPENSSL_CERTIFICATE_HASH`                      | `sha512`            |
| `OPENSSL_CERTIFICATE_SUBJECT_COUNTRY`           | `CO`                |
| `OPENSSL_CERTIFICATE_SUBJECT_STATE`             | `ST`                |
| `OPENSSL_CERTIFICATE_SUBJECT_LOCATION`          | `Location`          |
| `OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION`      | `Organization`      |
| `OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION_UNIT` | `Organization unit` |
| `OPENSSL_KEY_SIZE`                              | `4096`              |
| `OPENSSL_PRIVATE_KEY_ENCRYPTION`                | `des3`              |
| `OPENSSL_PRIVATE_KEY_PASSWORD`                  |                     |
| `SITE_DOMAIN`                                   | `domain.test`       |
