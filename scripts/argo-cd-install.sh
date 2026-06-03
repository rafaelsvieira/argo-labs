#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HELM_VALUES_FILE="${REPO_ROOT}/platform/argo-cd/helm/values.yaml"
HELM_CHART_NAME="argo/argo-cd"
ARGO_NAMESPACE="argo-cd-labs"
CHART_VERSION="9.5.20"

if [[ ! -f "${HELM_VALUES_FILE}" ]]; then
  echo "Values file not found: ${HELM_VALUES_FILE}" >&2
  exit 1
fi

if kubectl get namespace "${ARGO_NAMESPACE}" >/dev/null 2>&1; then
  echo "Namespace '${ARGO_NAMESPACE}' already exists. Skipping create."
else
  echo "Creating namespace '${ARGO_NAMESPACE}'..."
  kubectl create namespace "${ARGO_NAMESPACE}"
fi

echo "Adding/updating Argo Helm repo..."
helm repo add argo https://argoproj.github.io/argo-helm >/dev/null 2>&1 || true
helm repo update argo

echo "Installing Argo CD chart ${CHART_VERSION} into namespace '${ARGO_NAMESPACE}'..."
helm upgrade --install argo-cd "${HELM_CHART_NAME}" \
  --namespace "${ARGO_NAMESPACE}" \
  --create-namespace \
  --version "${CHART_VERSION}" \
  --values "${HELM_VALUES_FILE}"
