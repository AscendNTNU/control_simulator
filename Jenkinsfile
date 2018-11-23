pipeline {
  agent {
    dockerfile {
      filename 'components/jenkins.dockerfile'
      args '--entrypoint=""'
      additionalBuildArgs '-t control_simulator_jenkins'
    }
  }
  stages {
    stage('fetch-resources') {
      steps {
        sh 'git submodule update --init --recursive'
      }
    }
    stage('build-resources') {
      steps {
        sh 'make'
      }
    }
  }
  post {
    cleanup {
      cleanWs()
    }
  }
}

