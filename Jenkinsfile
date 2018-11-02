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
          sh 'catkin_make'
        }
      }
    }
  }
}

