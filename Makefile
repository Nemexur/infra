all: help

.PHONY: help
#> Display this message and exit
help:
	@echo "Commands:"
	@awk 'match($$0, "^#>") { sub(/^#>/, "", $$0); doc=$$0; getline; split($$0, c, ":"); cmd=c[1]; print "  \033[00;32m"cmd"\033[0m"":"doc }' Makefile | column -t -s ":"

.PHONY: setup
#> Install ansible-galaxy collections and roles
install:
	ansible-galaxy install --role-file requirements.yaml -v

.PHONY: lint
#> Run linters in the codebase
lint:
	@echo "[ \033[00;33mYamllint\033[0m ]"
	yamllint .
	@echo "[ \033[00;33mAnsible-lint\033[0m ]"
	ansible-lint
