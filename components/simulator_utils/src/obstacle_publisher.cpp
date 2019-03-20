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

geometry_msgs::PoseStamped::ConstPtr dronePoseMsg;
void dronePoseCallback(geometry_msgs::PoseStamped::ConstPtr msg) {
  dronePoseMsg = msg;
}

const std::string model_states_topic = "/gazebo/model_states";
const std::string pose_topic = "mavros/local_position/pose";
float boundingBoxRadius = 0.3;

int main(int argc, char** argv) {
  ros::init(argc, argv, "close_obstacle_detector");
  ros::NodeHandle n;
  ros::Publisher obstaclePub = n.advertise<ascend_msgs::ObstacleBoundingBoxes>("obstacles", 1);
  ros::Subscriber gazeboSub = n.subscribe(model_states_topic, 10, gazeboModelStatesCallback);
  ros::Subscriber poseSub = n.subscribe(pose_topic, 10, dronePoseCallback);

  ros::topic::waitForMessage<gazebo_msgs::ModelStates>(model_states_topic, n);
  ros::topic::waitForMessage<geometry_msgs::PoseStamped>(pose_topic, n);
  ros::spinOnce();

  ros::Rate rate(10.f);
  while (ros::ok()) {
    ros::spinOnce();
    rate.sleep();

    ascend_msgs::ObstacleBoundingBoxes obstacleMsg;
    obstacleMsg.layout.size = 0;

    const int len = modelStatesMsg->name.size();
    const auto& name = modelStatesMsg->name;
    const auto& pose = modelStatesMsg->pose;
    for (int i = 0; i < len; i++) {
      if (name[i].find("obstacle") != std::string::npos) {
        // Relative position
        // TODO: does this need to be rotated relative to the drone
        const auto relX = pose[i].position.x - dronePoseMsg->pose.position.x;
        const auto relY = pose[i].position.y - dronePoseMsg->pose.position.y;

        // Build bounding boxes and calculate distances
        geometry_msgs::Point32 minPoint;
        minPoint.x = relX - boundingBoxRadius;
        minPoint.y = relY - boundingBoxRadius;
        const auto minDistance = sqrt(minPoint.x*minPoint.x + minPoint.y*minPoint.y);
        geometry_msgs::Point32 maxPoint;
        maxPoint.x = relX + boundingBoxRadius;
        maxPoint.y = relY + boundingBoxRadius;
        const auto maxDistance = sqrt(maxPoint.x*maxPoint.x + maxPoint.y*maxPoint.y);
        
        // Place data in msg
        obstacleMsg.layout.size++;
        obstacleMsg.points.push_back(minPoint);
        obstacleMsg.points.push_back(maxPoint);
        obstacleMsg.distances.push_back(minDistance);
        obstacleMsg.distances.push_back(maxDistance);
      }
    }  

    obstaclePub.publish(obstacleMsg);
  }

  return 0;
}

