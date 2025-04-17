if [[ -f /etc/redhat-release ]]; then
  # On RedHat systems, ensure request uses systems ca bundle
  export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
  export SSL_CERT_FILE=${REQUESTS_CA_BUNDLE}
fi
