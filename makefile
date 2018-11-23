
all: sitl-gazebo-plugins custom-gazebo-plugins iris-models build-images

.PHONY:
custom-gazebo-plugins:
	cd gzresources && \
	mkdir -p build && \
	cd build && \
	cmake ../src && \
	make && \
	cp *.so ../plugins

.PHONY:
sitl-gazebo-plugins:
	cd gzresources/sitl_gazebo && \
	mkdir -p build && \
	cd build && \
	cmake .. && \
	make && \
	cp *.so ../../plugins 

.PHONY:
iris-models:
	cd scripts && \
	./make_iris.sh 4

.PHONY:
build-images: sitl-gazebo-plugins custom-gazebo-plugins iris-models
	docker build -t ascendntnu/control_simulator_pc_node -f components/computer.dockerfile .
	docker build -t ascendntnu/gzweb --build-arg GZRESOURCES_DIR=gzresources -f components/gzweb.dockerfile .
	docker build -t ascendntnu/gzserver --build-arg GZRESOURCES_DIR=gzresources -f components/gzserver.dockerfile .
	docker build -t ascendntnu/px4 -f components/px4.dockerfile .





