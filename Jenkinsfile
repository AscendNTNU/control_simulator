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
          sh 'whoami'
          #sh '. /opt/ros/kinetic/setup.sh && catkin_make'
        }
      }
    }
  }
}

