pipeline {
  agent {
    dockerfile {
      filename 'components/jenkins.dockerfile'
      args '..entrypoint=""'
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

