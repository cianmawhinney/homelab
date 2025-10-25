
lint: lint-yaml ## Lint everything

lint-yaml: ## Lint just the YAML in the repository
	yamllint .

.PHONY: up
up: registry-up flux-push flux-up ## Create the local cluster and registry, install Flux and the cluster addons
	kubectl -n flux-system wait kustomization/flux-system --for=condition=ready --timeout=5m
	kubectl -n flux-system wait kustomization/apps-sync --for=condition=ready --timeout=5m

.PHONY: sync
sync: flux-push ## Build, push and reconcile the manifests
	flux reconcile ks flux-system --with-source
	flux reconcile ks apps-sync --with-source

.PHONY: down
down: registry-down flux-down ## Delete the local registry and uninstall flux from cluster

.PHONY: registry-up
registry-up:
	scripts/registry/up.sh

.PHONY: registry-down
registry-down:
	scripts/registry/down.sh

.PHONY: flux-up
flux-up:
	scripts/flux/up.sh

.PHONY: flux-push
flux-push:
	scripts/flux/push.sh

.PHONY: flux-down
flux-down:
	scripts/flux/down.sh




# Taken from https://stackoverflow.com/a/64996042
help: ## Show this help text
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'
