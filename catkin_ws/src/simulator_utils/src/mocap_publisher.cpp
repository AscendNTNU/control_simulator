#include <ros/ros.h>
#include <string>
#include <geometry_msgs/PoseStamped.h>

class DroneWatcher {
  private:
    const std::string droneName;

  public:
    DroneWatcher() = delete;
    DroneWatcher(const std::string& droneName) 
      : droneName(droneName)
    {
    }
};

geometry_msgs::PoseStamped::ConstPtr poseMsg;

void callback(const geometry_msgs::PoseStamped::ConstPtr pose) {
  poseMsg = pose;
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "mocap_node");
  ros::NodeHandle nh;

  // Get drones from parameter server
  //std::string droneName;
  //std::string publishTopics;

  //if (!nh.getParam("drone_name", droneName)) {
  //  ROS_ERROR("Unable to load parameter drone_name");
  //}

  //if (droneName.size() == 0) {
  //  ROS_WARN("No drone name given");
  //  return 1;
  //}

  //std::vector<DroneWatcher> droneWatchers;
  //droneWatchers.emplace_back(droneName);


  ROS_INFO("Subscribing to topic");
  ros::Subscriber sub = nh.subscribe("not_mavros/local_position/pose", 1, callback);

  ros::Rate rate(1);

  ROS_INFO("Going into while loop");
  while (ros::ok()) {
    if (poseMsg) {
      std::cout << poseMsg->pose.position << std::endl;
      ROS_INFO_STREAM("Position:" << poseMsg->pose.position);
    }


    ROS_INFO_STREAM("ptr:" << poseMsg);

    rate.sleep();
  }

  return 0;
}


