#include <ros/ros.h>
#include <std_msgs/String.h>

int main(int argc, char** argv) {
  ros::init(argc, argv, "test_pkg");
  ros::NodeHandle n;
  ros::Publisher pub = n.advertise<std_msgs::String>("/test_pkg/msg", 1);
  ros::Rate rate(0.5);
  
  int msg_counter = 1;
  while (ros::ok() && msg_counter < 10) {
    std_msgs::String msg;
    msg.data = "Message number" + std::to_string(msg_counter);
    pub.publish(msg);
    ROS_INFO("%s", msg.data.c_str());
    msg_counter++;

    rate.sleep();
  }


  ROS_INFO("No more messages to publish");
  return 0;
}

