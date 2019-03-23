# Control Simulator
This repository contains a simulator for IARC mission 8. It provides a map the size of a basketball court, enemy drone and up to Ascend drones. It's purpose is to provide a playground for testing control systems such as state machine, obstacle avoidance and path-planning. 

## Quickstart
### Download repository
This repository is set up as a ROS package. Clone it into your catkin workspace. Note that there are a couple of submodules here, so it should be cloned using
```bash
# Either use this:
git clone --recursive https://github.com/AscendNTNU/control_simulator.git

# Or use this:
git clone --recursive https://github.com/AscendNTNU/control_simulator.git
cd control_simulator
git submodule update --init --recursive
```

### Build simulator
After installing into the catkin workspace, build and source it using standard ROS procedures.
```bash
catkin build    # catkin_make should also work fine
source devel/setup.zsh
```

### Run simulator
Use roslaunch to start the simulator.
```bash
roslaunch control_simulator main.launch
```
`main.launch` will start a normal gazebo instance with gui. 


## Troubleshooting

### ODOM: Ex: 
This isn't strictly related to control_simulator, but as of early 2019, there seems to be a bug in MAVROS odometry plugin causing it to crash. This means that the drones wont know their position and believe they start in the origin. The only solution I've found is to manually install an older version of mavros from source. Version 0.26.1 works, but it is worth trying newer versions as well. 
