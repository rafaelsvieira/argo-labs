# Gateway API

This directory contains the cluster-scoped Gateway API entrypoint used by the
frontend `HTTPRoute`.

The current frontend chart expects:

- namespace: `gateway-system`
- gateway name: `shared-gateway`

Important:

- This manifest assumes a Gateway API controller is already installed.
- The `gatewayClassName` is currently set to `nginx`, which should match the
  GatewayClass exposed by your chosen controller. If your controller uses a
  different GatewayClass name, update `shared-gateway.yaml` to match it.
