pipeline {
  agent { docker { image 'ros:kinetic-ros-base'} }
  stages {
    stage('build') {
      steps {
        sh 'cd catkin_ws'
        sh 'catkin_make'
      }
    }
  }
}

