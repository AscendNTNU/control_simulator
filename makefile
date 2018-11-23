
all: sitl-gazebo-plugins custom-gazebo-plugins iris-models

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


