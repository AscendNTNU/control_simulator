#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <ignition/math/Vector3.hh>

namespace gazebo 
{
  class ParrotPlugin : public ModelPlugin
  {
    public: void Load(physics::ModelPtr _parent, sdf::ElementPtr _sdf)
            {
                this->model = _parent;
                body = this->model->GetLink("body");
                prop_fl = this->model->GetJoint("fl_joint")->GetChild();

                //this->updateConnection = event::Events::ConnectWorldUpdateBegin(
                //    std::bind(&ParrotPlugin::OnUpdate, this));
            }
    //public: void OnUpdate()
    //        {
    //            // Check velocity and spin propellers accordingly

    //            //this->prop_fl->SetAngularVel(ignition::math::Vector3d(0,0,1.0));
    //            //this->body->SetAngularVel(ignition::math::Vector3d(0,0,0));
    //        }

    private: physics::ModelPtr model;
             
    private: physics::LinkPtr body;
    private: physics::LinkPtr prop_fl, prop_fr, prop_bl, prop_br;

    private: event::ConnectionPtr updateConnection;
  };


  GZ_REGISTER_MODEL_PLUGIN(ParrotPlugin);
}
