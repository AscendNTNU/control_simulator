
local: sitl-gazebo-plugins custom-gazebo-plugins iris-models 

.PHONY:
custom-gazebo-plugins:
	cd gzresources && \
	mkdir -p plugins && \
	mkdir -p build && \
	cd build && \
	cmake ../src && \
	make && \
	cp *.so ../plugins

.PHONY:
sitl-gazebo-plugins:
	cd gzresources && \
	mkdir -p plugins && \
	cd sitl_gazebo && \
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
prebuild: sitl-gazebo-plugins custom-gazebo-plugins iris-models

.PHONY:
build-images: build-image-pcnode build-image-gzweb build-image-gzserver build-image-px4

.PHONY:
build-image-pcnode: prebuild
	docker build -t ascendntnu/control_simulator_pc_node -f components/computer.dockerfile .

.PHONY:
build-image-gzweb: prebuild
	docker build -t ascendntnu/gzweb --build-arg GZRESOURCES_DIR=gzresources -f components/gzweb.dockerfile .

.PHONY:
build-image-gzserver: prebuild
	docker build -t ascendntnu/gzserver --build-arg GZRESOURCES_DIR=gzresources -f components/gzserver.dockerfile .

.PHONY:
build-image-px4: prebuild
	docker build -t ascendntnu/px4 -f components/px4.dockerfile .

.PHONY:
upload-images: 
	docker login
	docker push ascendntnu/control_simulator_pc_node
	docker push ascendntnu/gzweb
	docker push ascendntnu/gzserver
	docker push ascendntnu/px4

