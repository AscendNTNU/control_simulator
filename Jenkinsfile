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
          sh 'echo Going into catkin_ws'
          sh 'ls'
          sh 'echo Starting to build catkin_ws'
          sh 'catkin_make'
        }
      }
    }
  }
}

