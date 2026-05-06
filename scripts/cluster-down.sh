#!/usr/bin/env bash
# Tear down the argo-lab kind cluster.
set -euo pipefail

CLUSTER_NAME="argo-lab"

if ! kind get clusters 2>/dev/null | grep -qx "${CLUSTER_NAME}"; then
  echo "Cluster '${CLUSTER_NAME}' does not exist. Nothing to do."
  exit 0
fi

echo "Deleting kind cluster '${CLUSTER_NAME}'..."
kind delete cluster --name "${CLUSTER_NAME}"
