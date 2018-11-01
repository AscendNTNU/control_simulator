#include <ros/ros.h>
#include <std_msgs/String.h>



void callback(std_msgs::String::ConstPtr msg_p) {
  ROS_INFO("got msg: %s", msg_p->data.c_str());
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "listener");
  ros::NodeHandle n;
  ros::Subscriber sub =  n.subscribe("/publisher/msg", 1, callback);

  ros::spin();

  return 0;
}

