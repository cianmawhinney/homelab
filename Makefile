
lint: lint-yaml ## Lint everything

lint-yaml: ## Lint just the YAML in the repository
	yamllint .
	

# Taken from https://stackoverflow.com/a/64996042
help: ## Show this help text
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'
