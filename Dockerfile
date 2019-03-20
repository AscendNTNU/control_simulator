FROM ros:kinetic


WORKDIR /root/control_simulator/catkin_ws/src
COPY components .

CMD bash
