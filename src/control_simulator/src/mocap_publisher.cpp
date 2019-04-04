#include <ros/ros.h>
#include <string>
#include <map>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/Pose.h>
#include <gazebo_msgs/ModelStates.h>
#include <mavros_msgs/WaypointList.h>

class DronePosePub {
  private:
    const std::string name;
    ros::Publisher pub;

  public:
    DronePosePub(ros::NodeHandle& nh, const std::string& name, const std::string& topic) 
        : name(name)
    {
      pub = nh.advertise<geometry_msgs::PoseStamped>(topic, 1);
    }

    std::string getName() const { return name; }

    void publish(geometry_msgs::Pose pose) const {
      geometry_msgs::PoseStamped poseStamped;
      poseStamped.header.stamp = ros::Time::now();
      poseStamped.header.frame_id = "map";
      poseStamped.pose = pose;

      pub.publish(poseStamped);
    }
};

gazebo_msgs::ModelStates::ConstPtr modelStatesMsg;
void gazeboModelStatesCallback(gazebo_msgs::ModelStates::ConstPtr msg) {
  modelStatesMsg = msg;
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "positioning_node");
  ros::NodeHandle nh;
  
  ros::spinOnce();
  
  std::string drone_name_gazebo;
  std::string drone_name_gazebo_param = ros::this_node::getName() + "/drone_name";
  if (!nh.getParam(drone_name_gazebo_param, drone_name_gazebo)) {
      ROS_FATAL("Unable to load parameter %s (have %s) in namespace %s", drone_name_gazebo_param.c_str(), drone_name_gazebo.c_str(), nh.getNamespace().c_str());
      return 1;
  }
  ROS_INFO("Positioning node uses drone_name %s", drone_name_gazebo.c_str());

  ros::Subscriber sub = nh.subscribe("/gazebo/model_states", 1, gazeboModelStatesCallback);
  ros::topic::waitForMessage<mavros_msgs::WaypointList>("mavros/mission/waypoints");
  
  //std::vector<std::string> droneNames = {"alpha", "bravo"};
  std::vector<DronePosePub> dronePubs;
  dronePubs.emplace_back(nh, drone_name_gazebo, "mavros/vision_pose/pose");

  ros::Rate rate(10);
  while (ros::ok()) {
    ros::spinOnce();
    rate.sleep();

    if (!modelStatesMsg) {
      continue;
    }

    // extract dronePoses from msg
    bool found = false;
    for (const auto& dronePub : dronePubs) {
      const auto it = std::find(modelStatesMsg->name.cbegin(), modelStatesMsg->name.cend(), dronePub.getName());
      if (it == modelStatesMsg->name.cend()) {
        continue;
      }
      ROS_INFO_ONCE("Found %s in model_states", drone_name_gazebo.c_str());
      found = true;
      const size_t index = std::distance(modelStatesMsg->name.cbegin(), it);
      dronePub.publish(modelStatesMsg->pose[index]);
    }
    
    if (!found) {
        ROS_WARN_THROTTLE(20, "could not find %s in model_states", drone_name_gazebo.c_str());
    }
  }

  return 0;
}


