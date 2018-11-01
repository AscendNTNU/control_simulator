pipeline {
  agent { docker { image 'ros:kinetic-ros-base'} }
  stages {
    stage('build') {
      dir ('catkin_ws') {
        steps {
          sh 'catkin_make'
        }
      }
    }
  }
}

