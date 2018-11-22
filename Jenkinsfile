pipeline {
  agent {
    dockerfile {
      filename 'components/jenkins.dockerfile'
      args '--entrypoint=""'
      additionalBuildArgs '-t control_simulator_jenkins'
      }
  }
  stages {
    stage('fetch-submodules') {
      steps {
        sh 'git submodule update --init --recursive'
      }
    }
    stage('compile-plugins') {
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
              sh 'cmake .. && make'
              sh 'cp *.so ../../plugins'
            }
          }
        }
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

