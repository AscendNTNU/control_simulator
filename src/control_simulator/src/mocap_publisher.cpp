#include <ros/ros.h>
#include <string>
#include <map>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/Pose.h>
#include <tf/transform_broadcaster.h>
#include <gazebo_msgs/ModelStates.h>
#include <mavros_msgs/WaypointList.h>
#include <mavros_msgs/ParamSet.h>

class DronePosePub {
  private:
    const std::string name;
    ros::Subscriber gzSub;
    ros::Publisher posePub;
    tf::TransformBroadcaster tfPub;

    bool recievedPose = false;
    geometry_msgs::Pose pose;

    void gazeboModelStatesCallback(gazebo_msgs::ModelStates::ConstPtr msg) {
      const auto it = std::find(msg->name.cbegin(), msg->name.cend(), this->getName());
      if (it == msg->name.cend()) {
        ROS_WARN_THROTTLE(20, "could not find %s in model_states", name.c_str());
        return;
      }
      recievedPose = true;
      ROS_INFO_ONCE("Found %s in model_states", this->getName().c_str());
      const size_t index = std::distance(msg->name.cbegin(), it);
      pose = msg->pose[index];
    }

  public:
    DronePosePub(ros::NodeHandle& nh, const std::string& name, const std::string& topic) 
        : name(name) {
      posePub = nh.advertise<geometry_msgs::PoseStamped>(topic, 1);
      gzSub = nh.subscribe("/gazebo/model_states", 1, &DronePosePub::gazeboModelStatesCallback, this);
    }

    std::string getName() const { 
      return name; 
    }

    void publish() {
      if (recievedPose) {
        geometry_msgs::PoseStamped poseStamped;
        poseStamped.header.stamp = ros::Time::now();
        poseStamped.header.frame_id = "map";
        poseStamped.pose = pose;
        posePub.publish(poseStamped);

        tf::Transform tf;
        const auto& pos = pose.position;
        tf.setOrigin({pos.x, pos.y, pos.z});
        const auto& quat = pose.orientation;
        tf.setRotation({quat.x, quat.y, quat.z, quat.w});

        tfPub.sendTransform(tf::StampedTransform(tf, ros::Time::now(), "world", getName() + "/base_link"));
      }
    }
};

bool mavparamIntSet(ros::NodeHandle& nh, const std::string& param_id, int value) {
  ROS_INFO("Setting %s to %i", param_id.c_str(), value);
  ros::ServiceClient mavparam = nh.serviceClient<mavros_msgs::ParamSet>("mavros/param/set");
  mavros_msgs::ParamSet ps;
  ps.request.param_id = param_id;
  ps.request.value.integer = value;
  if (!mavparam.call(ps) || !ps.response.success) {
      ROS_WARN("Failed to set %s, please set manually to %ld", ps.request.param_id.c_str(), ps.request.value.integer);
  } else {

  }
}

bool waypoint_recieved = false;
void wpListCb(mavros_msgs::WaypointList::ConstPtr msg) {
  waypoint_recieved = true;
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

  ros::Subscriber wpSub = nh.subscribe("mavros/mission/waypoints", 1, wpListCb);
  bool mavparam_set = false;
  
  //std::vector<std::string> droneNames = {"alpha", "bravo"};
  DronePosePub dronePub(nh, drone_name_gazebo, "mavros/vision_pose/pose");

  ros::Rate rate(10);
  while (ros::ok()) {
    ros::spinOnce();
    rate.sleep();

    dronePub.publish();

    if (waypoint_recieved && !mavparam_set) {
      const bool success = mavparamIntSet(nh, "EKF2_AID_MASK", 24); // vision_pose and vision_yaw fusion
      mavparam_set = success;
      if (success) {
        wpSub.shutdown(); // subscriber is not longer needed
      }
    }
  }

  return 0;
}


