pipeline {
  agent { 
    dockerfile {
      filename 'computer/Dockerfile'
      additionalBuildArgs '--build-arg DONT_BUILD=true'
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

