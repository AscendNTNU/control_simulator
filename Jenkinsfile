pipeline {
  agent { 
    dockerfile 'computer/Dockerfile'
    additionalBuildArgs '--build-arg DONT_BUILD=true'
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

