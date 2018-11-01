pipeline {
  agent { docker { image 'ros:kinetic'} }
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

