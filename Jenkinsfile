pipeline {
  agent any
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
        dir ('gzresources') {
          dir ('sitl_gazebo') {
            sh 'mkdir -p build'
            dir ('build') {
              sh 'export GAZEBO_MODEL_PATH=$PWD && cmake .. && make'
              sh 'cp *.so ../../plugins'
            }
          }
          sh 'mkdir -p build'
          dir ('build') {
            sh 'cmake ../src && make'
            sh 'cp *.so ../plugins'
          }
        }
        dir ('scripts') {
          sh './make_iris.sh 4'
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

