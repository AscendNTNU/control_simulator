pipeline {
  agent { 
    dockerfile {
      filename 'dockerfiles/jenkins.dockerfile'
      args '--entrypoint="" --user=root'
    }
  }
  stages {
    stage('build') {
      steps {
        dir ('catkin_ws') {
          sh '. /opt/ros/kinetic/setup.sh && catkin_make'
        }

        sh './build_plugins.sh'
      }
    }
  }
  post {
    always {
      sh 'rm -f gzresources/sitl_gazebo/models/iris/iris.sdf'
    }
  }
}

