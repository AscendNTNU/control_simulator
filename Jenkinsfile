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
          echo "Going into catkin_ws"
          ls
          echo "Starting to build catkin_ws"
          sh 'catkin_make'
        }
      }
    }
  }
}

