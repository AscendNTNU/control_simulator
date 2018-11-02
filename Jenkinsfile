pipeline {
  agent { 
    dockerfile {
      filename 'catkin_ws/buildserverDockerfile'
    }
  }
  stages {
    stage('build') {
      steps {
        dir ('catkin_ws') {
          sh '. /opt/ros/kinetic/setup.sh && catkin_make'
        }
      }
    }
  }
}

