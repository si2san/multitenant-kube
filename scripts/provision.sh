#!/bin/bash
set -e

echo "Provisioning Multitenant"

cd "$(dirname "$0")/.." || exit 1

echo "===> Auth Provisioning"
bash ./scripts/auth.sh
echo "================"

echo "===> Cafe Provisioning"
bash ./scripts/cafe.sh
echo "================"

echo "===> CMS Provisioning"
bash ./scripts/cms.sh
echo "================"

echo "===> Menu Provisioning"
bash ./scripts/menu.sh
echo "================"

echo "===> EC Provisioning"
bash ./scripts/ec.sh
echo "================"

# Needs to be in correct order 
FILES=(
  auth-proxy-service.yml
  cafe-proxy-service.yml
  cms-proxy-service.yml
  ec-proxy-service.yml
  menu-proxy-service.yml
  multitenant-ingress.yml
)

for file in "${FILES[@]}"; do
  if [[ -f "$file" ]]; then
    echo "Applying: $file"
    kubectl apply -f "$file"
  fi
done

echo "Done."
