#!/usr/bin/env bash
# Bring up the argo-labs kind cluster. Idempotent.
set -euo pipefail

CLUSTER_NAME="argo-labs"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG="${REPO_ROOT}/kind/kind-config.yaml"

if kind get clusters 2>/dev/null | grep -qx "${CLUSTER_NAME}"; then
  echo "Cluster '${CLUSTER_NAME}' already exists. Skipping create."
else
  echo "Creating kind cluster '${CLUSTER_NAME}'..."
  kind create cluster --config "${CONFIG}"
fi

echo
echo "Waiting for all nodes to be Ready..."
kubectl --context "kind-${CLUSTER_NAME}" wait --for=condition=Ready nodes --all --timeout=120s

echo
echo "Cluster info:"
kubectl --context "kind-${CLUSTER_NAME}" cluster-info
echo
echo "Nodes:"
kubectl --context "kind-${CLUSTER_NAME}" get nodes -o wide

if docker ps --filter "name=cloud-provider-kind" --filter "status=running" --format '{{.Names}}' | grep -qx "cloud-provider-kind"; then
  echo "cloud-controller-manager container is already running. Skipping start."
else
  VERSION="$(basename $(curl -s -L -o /dev/null -w '%{url_effective}' https://github.com/kubernetes-sigs/cloud-provider-kind/releases/latest))"
  echo "Starting cloud-controller-manager in a container for cloud-provider-kind version ${VERSION}..."
  docker run -d --name cloud-provider-kind --rm --network host -v /var/run/docker.sock:/var/run/docker.sock registry.k8s.io/cloud-provider-kind/cloud-controller-manager:${VERSION}
fi

echo "Cluster '${CLUSTER_NAME}' is up and running!"
