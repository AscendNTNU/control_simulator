#include <ros/ros.h>
#include <gazebo_msgs/ModelStates.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/Point32.h>
#include <std_msgs/String.h>
#include <ascend_msgs/ObstacleBoundingBoxes.h>
#include <functional>
#include <string>

gazebo_msgs::ModelStates::ConstPtr modelStatesMsg;
void gazeboModelStatesCallback(gazebo_msgs::ModelStates::ConstPtr msg) {
  modelStatesMsg = msg;
}

const std::string model_states_topic = "/gazebo/model_states";
const std::string target_topic = "perception/target";

int main(int argc, char** argv) {
  ros::init(argc, argv, "close_obstacle_detector");
  ros::NodeHandle n;
  ros::Publisher targetPub = n.advertise<geometry_msgs::Pose>(target_topic, 1);
  ros::Subscriber gazeboSub = n.subscribe(model_states_topic, 10, gazeboModelStatesCallback);

  ros::topic::waitForMessage<gazebo_msgs::ModelStates>(model_states_topic, n);
  ros::spinOnce();

  ros::Rate rate(10.f);
  while (ros::ok()) {
    ros::spinOnce();
    rate.sleep();

    geometry_msgs::Pose targetMsg;

    const int len = modelStatesMsg->name.size();
    const auto& name = modelStatesMsg->name;
    const auto& pose = modelStatesMsg->pose;
    for (int i = 0; i < len; i++) {
      if (name[i] == "obstacle_1") {
        targetPub.publish(pose[i]);
      }
    }  
  }

  return 0;
}

