pipeline {
  agent { docker { image 'ros:kinetic-ros-base'} }
  stages {
    stage('build') {
      steps {
        cd catkin_ws; 
        catkin_make;
      }
    }
  }
}

