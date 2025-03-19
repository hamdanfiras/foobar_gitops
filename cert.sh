#!/bin/bash

# Set the host and port
HOST="localhost"
PORT=5601

# Extract the certificate using openssl s_client.
# The sed command extracts the certificate block.
CERT=$(echo | openssl s_client -connect ${HOST}:${PORT} -servername ${HOST} 2>/dev/null | \
       sed -n '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p')

# Check if certificate extraction was successful.
if [ -z "$CERT" ]; then
    echo "Failed to retrieve certificate from ${HOST}"
    exit 1
fi

# Save the certificate to a file.
CERT_FILE="mycert.pem"
echo "$CERT" > "$CERT_FILE"
echo "Certificate saved to ${CERT_FILE}"

# Add the certificate to macOS trusted certificates.
# The -d flag indicates that the certificate should be trusted for SSL.
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERT_FILE"

if [ $? -eq 0 ]; then
    echo "Certificate added to trusted store successfully."
else
    echo "Failed to add certificate to trusted store."
    exit 1
fi
