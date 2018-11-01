pipeline {
  agent { docker { image 'ros:kinetic-ros-base'} }
  stages {
    stage('build') {
      steps {
        dir ('catkin_ws') {
          sh 'catkin_make'
        }
      }
    }
  }
}

