pipeline {
  agent {
    dockerfile {
      filename 'components/jenkkins.dockerfile'
      args '--entrypoint=""'
      additionalBuildArgs '-t control_simulator_jenkins'
      }
  }
  stages {
    stage('pre-build') {
      steps {
        sh 'git submodule update --init'
      }
    }
    stage('build') {
      steps {
        dir ('gzresources') {
          sh 'mkdir -p build'
          dir ('build') {
            sh 'cmake ../src && make'
            sh 'cp *.so ../plugins'
          }
          dir ('sitl_gazebo') {
            sh 'mkdir -p build'
            dir ('build') {
              sh 'cmake ../src && make'
              sh 'cp *.so ../plugins'
            }
          }
        }
      }
    }
  }
  post {
    cleanup {
      sh 'ls'
      sh 'ls catkin_ws'
      sh 'ls gzresources'

      cleanWs()
    }
  }
}

