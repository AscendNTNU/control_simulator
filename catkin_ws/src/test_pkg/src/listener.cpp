#include <ros/ros.h>
#include <std_msgs/String.h>



void callback(std_msgs::String::ConstPtr msg_p) {
  std::cout << "got msg: " << msg_p->data << std::endl;
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "listener");
  ros::NodeHandle n;
  ros::Subscriber sub =  n.subscribe("/publisher/msg", 1, callback);

  ros::spin();

  return 0;
}

