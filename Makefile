# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Er-doy
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

run-dev-server: ## Run the dev server
	hugo server -D

compile: ## Compile all of the static stuff for the site
	hugo

sync: ## Sync static stuff with the web host
	rsync -av --progress public/ blog:/home/public
