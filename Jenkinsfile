pipeline {
  agent any
  stages {
    stage('build-images') {
      steps {
        sh 'echo "not doing much here"'
      }
    }
  }
  post {
    cleanup {
      cleanWs()
    }
  }
}

