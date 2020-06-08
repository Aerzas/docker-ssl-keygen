#!/bin/sh
set -e

# Don't overwrite certificates
if [ -f "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.crt" ]; then
  echo "Certificate already exists."
  exec "$@"
  exit 0
fi

# Private key password
if [ -n "${OPENSSL_PRIVATE_KEY_PASSWORD}" ] && [ -n "${OPENSSL_PRIVATE_KEY_ENCRYPTION}" ]; then
  password_out="-${OPENSSL_PRIVATE_KEY_ENCRYPTION} -passout ${OPENSSL_PRIVATE_KEY_PASSWORD}"
  password_in="-passin ${OPENSSL_PRIVATE_KEY_PASSWORD}"
fi

subj="/C=${OPENSSL_CERTIFICATE_SUBJECT_COUNTRY}/ST=${OPENSSL_CERTIFICATE_SUBJECT_STATE}/L=${OPENSSL_CERTIFICATE_SUBJECT_LOCATION}/O=${OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION}/OU=${OPENSSL_CERTIFICATE_SUBJECT_ORGANIZATION_UNIT}/CN=*.${SITE_DOMAIN}"

openssl genrsa -out "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.rootCA.key" ${password_out} "${OPENSSL_KEY_SIZE}"
openssl req -x509 -new -nodes -key "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.rootCA.key" ${password_in} "-${OPENSSL_CERTIFICATE_HASH}" -days "${OPENSSL_CERTIFICATE_EXPIRATION}" -out "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.rootCA.crt" -subj "$subj"

openssl genrsa -out "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.key" "${OPENSSL_KEY_SIZE}"
openssl req -new "-${OPENSSL_CERTIFICATE_HASH}" -subj "$subj" -key "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.key" -out "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.csr" -config "${OPENSSL_ROOT}/openssl.cnf"
openssl x509 -req -in "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.csr" -CA "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.rootCA.crt" -CAkey "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.rootCA.key" ${password_in} -CAcreateserial -out "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.crt" -days "${OPENSSL_CERTIFICATE_EXPIRATION}" -extensions v3_req -extfile "${OPENSSL_ROOT}/openssl.cnf"

cat "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.crt" "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.key" >"${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.pem"
chmod 600 "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.key" "${OPENSSL_CERTIFICATES}/${SITE_DOMAIN}.pem"

exec "$@"
