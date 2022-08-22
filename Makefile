all: help

help:
	@echo "Commands:"
	@echo "  \033[00;32msetup\033[0m - prepare for installation."
	@echo "  \033[00;32mlint\033[0m  - run linting in the code base."

setup:
	ansible-galaxy install -vr requirements.yml
	@echo "[ \033[00;33mDo not forget to set OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES\033[0m ]"

lint:
	@echo "[ \033[00;33mYamllint\033[0m ]"
	yamllint .
	@echo "[ \033[00;33mAnsible-lint\033[0m ]"
	ansible-lint
