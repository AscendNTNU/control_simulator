

.PHONY:
all: containers gzplugins


.PHONY:
containers: gzplugins
	docker-compose build

.PHONY:
gzplugins:
	./build_plugins.sh
