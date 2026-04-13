
.PHONY: unit_test
unit_test:
	@export ANSIBLE_ROLES_PATH="$$(dirname "$$(pwd)")" ;\
		echo $$ANSIBLE_ROLES_PATH ;\
		ansible-playbook unit-tests.playbook.yml
