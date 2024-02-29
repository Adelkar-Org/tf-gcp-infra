#!/bin/bash

# Fetch database configuration from instance metadata
DB_NAME=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_name -H "Metadata-Flavor: Google")
DB_USER=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_user -H "Metadata-Flavor: Google")
DB_PASSWORD=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_password -H "Metadata-Flavor: Google")
DB_HOST=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_host -H "Metadata-Flavor: Google")

# Configure your application with these values
# This example assumes an environment file configuration for a Node.js app
cat > /opt/webapp/.env.development << EOF
PORT=8080
HOST="localhost"
DB_DIALECT="mysql"
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD 
DB_HOST=$DB_HOST
EOF

# Replace with your actual service start command or systemd unit reload if necessary
sudo systemctl start webapp.service
