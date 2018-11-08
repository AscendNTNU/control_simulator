pipeline {
  agent { 
    dockerfile {
      filename 'dockerfiles/jenkins.dockerfile'
      args '--entrypoint="" --user=root'
    }
  }
  stages {
    stage('build') {
      steps {
        dir ('catkin_ws') {
          sh '. /opt/ros/kinetic/setup.sh && catkin_make'
        }
        dir('gzresources/sitl_gazebo') {
          sh 'mkdir -p build'
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

