# Control Simulator


## Getting started
Make sure your computer fulfills the requirements below. 

We start the simulator using docker-compose.
```
docker-compose up
```
`docker-compose` creates an internal network and runs the different nodes specified in `docker-compose.yml`. This means that the nodes in the simulator run separated from the host. The ros master node is exposed, so you can interact with the ros nodes as you would running locally (see below). 

If all goes well, then you can open a web browser and view the simulation at `http://localhost:8080`. 

### Local access to ROS master
When the simulator is running, the ROS master is exposed to the host computer. Since this is a networked ROS application, we need to setup the environment variable ROS_IP.
This is taken care of by running
```
source expose_host.sh 
```
*TODO:* does this script work on other machines?

Verify that it works by running
```
rostopic list
rostopic echo /gazebo/model_states # should spam the console
```
After this, you can interact with the ROS nodes as on any other machine.

## Project Structure

### Architecture

### catkin_ws/
The catkin_ws folder is compiled and made available on the offboard computer and all onboard computers. 

### components/

### gzresources/

## Requirements
- recent version of docker ([link](https://docs.docker.com/install/linux/docker-ce/ubuntu/))
- recent version of docker-compose ([link](https://docs.docker.com/compose/install/))

## Development

### Recompiling plugins for gazebo
