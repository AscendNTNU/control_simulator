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
          sh 'catkin_make'
        }
      }
    }
  }
}

