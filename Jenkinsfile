pipeline {
  agent { 
    dockerfile {
      filename 'buildserver.Dockerfile'
      args '--entrypoint=""'
    }
  }
  stages {
    stage('build') {
      steps {
        dir ('catkin_ws') {
          sh 'ls'
          sh 'echo $(which catkin_make)'
        }
      }
    }
  }
}

