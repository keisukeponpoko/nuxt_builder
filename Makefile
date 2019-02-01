PROJECT = project_name

.PHONY: start
start:
	docker-compose -p $(PROJECT) up -d --build

.PHONY: restart
restart:
	docker-compose -p $(PROJECT) kill && \
	docker-compose -p $(PROJECT) rm -f && \
	docker-compose -p $(PROJECT) up -d --build

.PHONY: kill
kill:
	docker-compose -p $(PROJECT) kill

.PHONY: down
down:
	docker-compose -p $(PROJECT) down

.PHONY: ps
ps:
	docker-compose -p $(PROJECT) ps

.PHONY: rm_node_modules
rm_node_modules:
	docker volume rm project_name_node-modules-data
