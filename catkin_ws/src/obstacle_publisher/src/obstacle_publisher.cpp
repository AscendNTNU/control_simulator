#include <ros/ros.h>
#include <gazebo_msgs/ModelStates.h>
#include <geometry_msgs/PoseArray.h>
#include <functional>
#include <string>

geometry_msgs::PoseArray obstacles;

void sub_callback(const gazebo_msgs::ModelStates& models) {
  const size_t num_models = models.name.size();

  obstacles.header.stamp = ros::Time::now();
  obstacles.header.frame_id = "1";
  obstacles.poses.clear();
  for (size_t i = 0; i < num_models; i++) {
    if (models.name[i].find("obstacle") != std::string::npos) {
      obstacles.poses.push_back(models.pose[i]);
    }
  }
}

void publisher(const ros::Publisher& pub) {
  pub.publish(obstacles);
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "obstacle_publisher");
  ros::NodeHandle n;
  ros::Publisher pub = n.advertise<geometry_msgs::PoseArray>("/ai/close_obstacles", 1);
  ros::Subscriber sub = n.subscribe("/server/obstacles", 1, &sub_callback);

//ros::Timer pub_timer = n.createTimer(
//     ros::Duration(1.f), 
//     [](){ pub.publish(obstacles); });
  ros::Timer pub_timer = n.createTimer(
      ros::Duration(1.f),
      std::bind(publisher, pub));
  ROS_INFO("Obstacle publisher setup complete");


  ros::spin();
}

