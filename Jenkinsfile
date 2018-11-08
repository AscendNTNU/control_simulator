pipeline {
  agent { 
    dockerfile {
      filename 'dockerfiles/jenkins.dockerfile'
      args '--entrypoint=""'
      additionalBuildArgs '-t control_simulator_jenkins'
    }
  }
  stages {
    stage('pre-build') {
      steps {
        sh 'git submodule update --init'
      }
    }
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
    cleanup {
      sh 'ls'
      sh 'ls catkin_ws'
      sh 'ls gzresources'

      cleanWs()
      sh 'rm -f gzresources/sitl_gazebo/models/iris/iris.sdf'
    }
  }
}

