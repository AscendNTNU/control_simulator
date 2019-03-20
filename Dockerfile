FROM ros:kinetic


WORKDIR /root/control_simulator/catkin_ws
COPY components src


RUN apt-get update && apt-get install -y \
      python-jinja2

RUN bash -c "source /opt/ros/kinetic/setup.bash && catkin_make"

CMD bash
