# Control Simulator


## Getting started
Make sure your computer fulfills the requirements below. 

We start the simulator using docker-compose.
```
docker-compose up
```
`docker-compose` creates an internal network and run the different nodes specified in `docker-compose.yml`. This means that the nodes in the simulator run separated from the host. The ros master node is exposed, so you can interact with the ros nodes as you would running locally. 


## Project Structure

### Architecture

### catkin_ws/
The catkin_ws folder is compiled and made available on the offboard computer and all onboard computers. 

### components/

### gzresources/

## Requirements
- recent version of docker installed and running ([link](https://docs.docker.com/install/linux/docker-ce/ubuntu/))
- recent version of docker-compose ([link](https://docs.docker.com/compose/install/))

## Development

### Recompiling plugins for gazebo
