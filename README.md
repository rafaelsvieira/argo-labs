# argo-labs

A hands-on lab for learning **ArgoCD** and **Argo Rollouts** on a local Kubernetes cluster (kind). Each milestone produces working artifacts and a matching blog post.

## Layout

| Path | Purpose |
|---|---|
| `kind/` | kind cluster configs |
| `platform/` | cluster-wide installs (ArgoCD, ingress, rollouts controller, …) |
| `apps/` | workloads ArgoCD syncs |
| `scripts/` | helper scripts (cluster up/down, bootstrap, …) |
| `blog/` | one Markdown post per milestone, Mermaid diagrams welcome |
| `docs/images/` | screenshots and assets referenced by posts |

## Milestones

### Phase 1 — Foundation
- [x] 01 — [Bootstrap a kind cluster](blog/01-bootstrapping-kind.md)
- [x] 02 — Install ArgoCD, access the UI, the App CRD
- [ ] 03 — First "Hello GitOps" sync

### Phase 2 — GitOps patterns
- [ ] 04 — App-of-Apps vs ApplicationSets
- [ ] 05 — Sync waves, hooks, health checks
- [ ] 06 — Secrets in GitOps (sealed-secrets or SOPS)

### Phase 3 — Progressive delivery
- [ ] 07 — Install Argo Rollouts, replace a Deployment with a Rollout
- [ ] 08 — Canary with manual promotion
- [ ] 09 — Canary with traffic shifting (NGINX or Istio)
- [ ] 10 — Analysis templates with Prometheus
- [ ] 11 — Blue/green strategy

### Phase 4 — End-to-end
- [ ] 12 — PR-merge → ArgoCD sync → metric-gated canary

## Blog index

1. [Bootstrapping a kind cluster for the argo-labs](blog/01-bootstrapping-kind.md)
