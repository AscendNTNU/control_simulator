pipeline {
  agent {
    dockerfile {
      filename 'components/jenkins.dockerfile'
      args '--entrypoint="" -v /var/lib/jenkins/workspace/control_simulator:/.gazebo:rw'
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

