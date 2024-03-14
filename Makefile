DEFAULT_BRANCH := main

.PHONY: help
help:  ## Show available commands
	@echo "Available commands:"
	@echo
	@sed -n -E -e 's|^([A-Za-z0-9/_-]+):.+## (.+)|\1@\2|p' $(MAKEFILE_LIST) | column -s '@' -t

.PHONY: pre-commit
pre-commit:  ## Run pre-commit (optional: HOOK=example)
	pre-commit run --all-files --verbose --show-diff-on-failure --color always $(HOOK)

.PHONY: fmt
fmt:  ## Format all Terraform files
	terraform fmt -recursive .

.PHONY: bump-version/major
bump-version/major:  ## Increment the major version (X.y.z)
	bump2version major

.PHONY: bump-version/minor
bump-version/minor:  ## Increment the minor version (x.Y.z)
	bump2version minor

.PHONY:  bump-version/patch
bump-version/patch:  ## Increment the patch version (x.y.Z)
	bump2version patch

.PHONY: release
release:  ## Push the new project version
	git push --follow-tags origin $(DEFAULT_BRANCH)
