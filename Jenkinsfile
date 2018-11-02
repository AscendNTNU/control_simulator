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
          . /opt/ros/kinetic/setup.sh && catkin_make
        }
      }
    }
  }
}

