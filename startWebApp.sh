#!/bin/bash

DB_NAME=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_name -H "Metadata-Flavor: Google")
DB_USER=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_user -H "Metadata-Flavor: Google")
DB_PASSWORD=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_password -H "Metadata-Flavor: Google")
DB_HOST=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_host -H "Metadata-Flavor: Google")

cat > /opt/webapp/.env.development << EOF
PORT=8080
HOST="localhost"
DB_DIALECT="mysql"
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD 
DB_HOST=$DB_HOST
EOF

# sudo systemctl restart google-cloud-ops-agent

sudo systemctl start webapp.service
