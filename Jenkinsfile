pipeline {
  agent { 
    dockerfile {
      filename 'buildserver.Dockerfile'
      args '--entrypoint="" --user=root'
    }
  }
  stages {
    stage('pre build') {
      steps {
        sh 'git submodule update --init --recursive'
      }
    }
    stage('build') {
      steps {
        dir ('catkin_ws') {
          sh '. /opt/ros/kinetic/setup.sh && catkin_make'
        }
        dir('gzresources/sitl_gazebo') {
          sh 'mkdir build'
          sh 'whoami'
          dir ('build') {
            sh 'cmake ..'
            sh 'make'
          }
        }

      }
    }
  }
  post {
    always {
      cleanWs()
      sh 'rm -f gzresources/sitl_gazebo/models/iris/iris.sdf'
    }
  }
}

