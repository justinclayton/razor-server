#!/bin/bash

createuser -h $DB_PORT_5432_TCP_ADDR -U postgres root
createdb -h $DB_PORT_5432_TCP_ADDR -U postgres razor

cd /opt/razor
cat config.yaml.docker | sed -e "s/REPLACEME/${DB_PORT_5432_TCP_ADDR}/" > config.yaml
/opt/razor/bin/razor-admin -e production migrate-database
torquebox deploy --env production

torquebox run --bind-address=0.0.0.0
