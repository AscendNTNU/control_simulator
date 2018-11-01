pipeline {
  agent { docker { image 'ros:kinetic-ros-base'} }
  stages {
    stage('build') {
      steps {
        sh 'docker --version'
      }
    }
  }
}

