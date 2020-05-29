# Docker SSL Keygen

Minimalist helper docker container to generate self-signed certificates.

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
    -e OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION=Faering \
    -e OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION_UNIT=Docker \
    -e SITE_DOMAIN=docker.test \
    faering/ssl-keygen:1.0.0;
```

## Environment Variables

| Variable | Default Value
| --- | ---
| `OPENSSL_CERTIFICATE_EXPIRATION` | `825`
| `OPENSSL_CERTIFICATE_HASH` | `sha512`
| `OPENSSL_CERTIFICATE_SUBJECT_COUNTRY` | `CO`
| `OPENSSL_CERTIFICATE_SUBJECT_STATE` | `ST`
| `OPENSSL_CERTIFICATE_SUBJECT_LOCATION` | `Location`
| `OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION` | `Organization`
| `OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION_UNIT` | `Organization unit`
| `OPENSSL_KEY_SIZE` | `4096`
| `OPENSSL_PRIVATE_KEY_ENCRYPTION` | `des3`
| `OPENSSL_PRIVATE_KEY_PASSWORD`
| `SITE_DOMAIN` | `domain.test`
