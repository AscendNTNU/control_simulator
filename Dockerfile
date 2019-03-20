FROM ros:kinetic


WORKDIR /home/user/control_simulator
COPY . .

WORKDIR /control_simulator/catkin_ws
COPY components src
RUN cd src/Ascend-PX4 && git submodule update --init --recursive && \
  cd ../sitl_gazebo && git submodule update --init --recursive

RUN apt-get update && apt-get install -y \
      python-jinja2

#RUN bash -c "source /opt/ros/kinetic/setup.bash && catkin_make"

CMD bash
