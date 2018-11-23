pipeline {
  agent {
    dockerfile {
      filename 'components/jenkins.dockerfile'
      additionalBuildArgs '-t control_simulator_jenkins'
      }
  }
  stages {
    stage('fetch-resources') {
      steps {
        sh 'pwd'
        sh 'git submodule update --init --recursive'
      }
    }
    stage('build-resources') {
      steps {
        sh 'pwd'
        sh 'make'
      }
    }
  }
  post {
    cleanup {
      sh 'pwd'
      sh 'ls'
      sh 'ls catkin_ws'
      sh 'ls gzresources'

      cleanWs()
    }
  }
}

