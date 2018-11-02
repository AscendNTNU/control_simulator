pipeline {
  agent { 
    dockerfile {
      filename 'buildserver.Dockerfile'
    }
  }
  stages {
    stage('build') {
      steps {
        dir ('catkin_ws') {
          bash '. /opt/ros/kinetic/setup.sh && catkin_make'
        }
      }
    }
  }
}

