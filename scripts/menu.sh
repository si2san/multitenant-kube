#!/bin/bash
set -e

echo "Applying multitenant-menu"

cd "$(dirname "$0")/../multitenant-menu" || exit 1

# Needs to be in correct order 
FILES=(
  namespace.yml
  db-config-map.yml
  db-secret.yml
  db-statefulset.yml
  db-service.yml
  cache-statefulset.yml
  cache-service.yml
  nginx-config-map.yml
  app-config-map.yml
  app-job.yml
  app-deployment.yml
  app-hpa.yml
  app-service.yml
)

for file in "${FILES[@]}"; do
  if [[ -f "$file" ]]; then
    echo "Applying: $file"
    microk8s kubectl apply -f "$file"
  fi
done

echo "Done."
