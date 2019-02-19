pipeline {
  agent any
  stages {
    stage('build-images') {
      steps {
        sh './scripts/build_images.sh'
      }
    }
    stage('upload-images') {
      steps {
        sh 'make upload-images'
      }
    }
  }
  post {
    cleanup {
      cleanWs()
    }
  }
}

