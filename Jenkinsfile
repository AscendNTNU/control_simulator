pipeline {
  agent any
  stages {
    stage('build-images') {
      steps {
        sh './scripts/build_images.sh'
      }
    }
  }
  post {
    cleanup {
      cleanWs()
    }
  }
}

