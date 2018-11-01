#include <ros/ros.h>
#include <std_msgs/String.h>


int main(int argc, char** argv) {
  ros::init(argc, argv, "publisher");
  ros::NodeHandle n;
  ros::Publisher pub =  n.advertise<std_msgs::String>("/publisher/msg", 1);

  std_msgs::String msg;
  msg.data = "Hello!";

  ros::Rate rate(0.5f);
  while (pub.getNumSubscribers() == 0) {
    ROS_INFO("No subscribers");
    rate.sleep();
  }

  ROS_INFO("Subscriber attached");

  while (ros::ok() && pub.getNumSubscribers() > 0) {
    pub.publish(msg);
    rate.sleep();
  }

  return 0;
}

