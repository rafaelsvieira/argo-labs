#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Bringing up the cluster..."
"${REPO_ROOT}/scripts/cluster-up.sh"

echo "Installing Argo CD..."
"${REPO_ROOT}/scripts/argo-cd-install.sh"

echo "Applying shared gateway configuration..."
kubectl apply -f "${REPO_ROOT}/platform/gateway-api/shared-gateway.yaml"

echo "Applying Argo CD application configuration..."
kubectl apply -f "${REPO_ROOT}/platform/argo-cd/applications/click-lab.yaml"
kubectl apply -f "${REPO_ROOT}/platform/argo-cd/applications/dev-app.yaml"

echo "All done! The cluster is ready and Argo CD is installed with the application set up."
