pipeline {
  agent { docker { image 'ros:kinetic'} }
  stages {
    stage('build') {
      steps {
        dir ('catkin_ws') {
          sh 'source /opt/ros/kinetic/setup.sh && catkin_make'
        }
      }
    }
  }
}

