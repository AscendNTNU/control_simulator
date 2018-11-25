#include <functional>
#include <random>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <ignition/math/Vector3.hh>

namespace gazebo 
{
  class ModelPush : public ModelPlugin
  {
    public: void Load(physics::ModelPtr _parent, sdf::ElementPtr _sdf)
            {
              this->model = _parent;

              x_min = _sdf->GetElement("x_min")->Get<float>();
              x_max = _sdf->GetElement("x_max")->Get<float>();
              y_min = _sdf->GetElement("y_min")->Get<float>();
              y_max = _sdf->GetElement("y_max")->Get<float>();

              if (_sdf->HasElement("altitude")) {
                altitude = _sdf->GetElement("altitude")->Get<float>();
              }

              if (_sdf->HasElement("speed")) {
                speed = _sdf->GetElement("speed")->Get<float>();
              }

              std::random_device rd;
              this->generator = std::mt19937(rd());
              x_distribution = std::uniform_real_distribution<float>(x_min, x_max);
              y_distribution = std::uniform_real_distribution<float>(y_min, y_max);
              time_distribution = std::uniform_real_distribution<float>(10.f, 40.f);

              x_goal = x_distribution(generator);
              y_goal = y_distribution(generator);
              change_time = time_distribution(generator);

              timer.Start();

              this->updateConnection = event::Events::ConnectWorldUpdateBegin(
                  std::bind(&ModelPush::OnUpdate, this));
            }
    public: void OnUpdate()
            {
              auto seconds = timer.GetElapsed();

              if (seconds > change_time) {
                timer.Reset();
                timer.Start();

                x_goal = x_distribution(generator);
                y_goal = y_distribution(generator);
                change_time = time_distribution(generator);
              }

              const float x_curr = this->model->GetWorldPose().pos.x;
              const float y_curr = this->model->GetWorldPose().pos.y;
              const float z_curr = this->model->GetWorldPose().pos.z;

              const float Kp = 0.1f;

              ignition::math::Vector3d vel = Kp*ignition::math::Vector3d{x_goal - x_curr, y_goal - y_curr, altitude - z_curr};
              if (vel.Length() > speed) {
                vel = speed*vel.Normalized();
              }

              this->model->SetLinearVel(vel);
            }

    private: physics::ModelPtr model;

    private: event::ConnectionPtr updateConnection;

    private: float x_min=0.f, x_max=0.f, y_min=0.f, y_max=0.f, x_goal=0.f, y_goal=0.f, speed=1.f, altitude=2.f, change_time=5.f;

    private: common::Timer timer;

    private: std::uniform_real_distribution<float> x_distribution;
    private: std::uniform_real_distribution<float> y_distribution;
    private: std::uniform_real_distribution<float> time_distribution;
    private: std::mt19937 generator;
  };


  GZ_REGISTER_MODEL_PLUGIN(ModelPush);
}
