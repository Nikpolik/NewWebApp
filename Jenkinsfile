pipeline {
    agent any
    triggers {
      githubPush()
    }
    environment {
        IMAGE_NAME = "nikpolik/newwebapp"
        RUNNING_CONTAINERS = sh (
                  script: 'docker ps -a -q',
                  returnStdout: true
              ).trim()
      DOCKER_CRED = credentials('nikpolik-docker')
    }
    stages {
        stage('Build Web App') {
            steps {
                echo 'Builing War file...'
                sh 'mvn clean package'
            }
        }
        stage ('Build Docker Image') {
          steps {
            echo 'Login in to dockerhub...'
            sh 'docker login -u ${DOCKER_CRED_USR} -p ${DOCKER_CRED_PSW}'
            echo 'Building Image...'
            sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
            sh 'docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest'
            echo 'Publishing image...'
            sh 'docker push ${IMAGE_NAME}'
          }
        }
        stage('Cleanup') {
          when {
            not {
              environment name: 'RUNNING_CONTAINERS', value: ''
            }
          }
          steps {
            echo 'Stopping previous running containers...'
            sh 'docker stop ${RUNNING_CONTAINERS}'
            sh 'docker rm ${RUNNING_CONTAINERS}'
          }
        }
        stage('Deploy') {
          steps {
            echo 'Running new image...'
            sh 'docker run -d -p 8088:8080 ${IMAGE_NAME}:latest'
            echo 'Deployed'
          }
        }
    }
}
