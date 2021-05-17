pipeline {
    agent any
    triggers {
      githubPush()
    }
    environment {
        IMAGE_NAME = 'nikpolik/newwebapp'
        RUNNING_CONTAINERS = sh (
                  script: 'docker ps -a -q',
                  returnStdout: true
              ).trim()
      DOCKER_CRED = credentials('nikpolik-docker')
      MYSQL_CRED = credentials('mysql')
    }
    stages {
        stage('Stop Instanses') {
          when {
            not {
              environment name: 'RUNNING_CONTAINERS', value: ''
            }
          }
          steps {
            echo 'Stopping previous running containers...'
            sh "docker rm -f ${RUNNING_CONTAINERS}"
          }
        }
        stage('Build Web App') {
          steps {
            echo 'Builing War file...'
            sh 'mvn clean package'
          }
        }
        stage ('Build Docker Image') {
          steps {
            echo 'Login in to dockerhub...'
            sh "docker login -u ${DOCKER_CRED_USR} -p ${DOCKER_CRED_PSW}"
            echo 'Building Image...'
            sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            sh "docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"
            echo 'Publishing image...'
            sh "docker push ${IMAGE_NAME}"
          }
        }
        stage('Deploy Database Container') {
          steps {
            fileOperations([
              folderCopyOperation(sourceFolderPath: './scripts', destinationFolderPath: '/home/ubuntu/scripts')
            ])
            sh """
              docker run -p 3306:3306 --name mysql-server \
                -v /home/ubuntu/scripts:/docker-entrypoint-initdb.d \
                -e MYSQL_ROOT_PASSWORD=${MYSQL_CRED_PSW} \
                -e MYSQL_USER=${MYSQL_CRED_USR} \
                -e MYSQL_PASSWORD=${MYSQL_CRED_PSW} \
                -d mysql:latest
            """
          }
        }
        stage('Deploy Webserver Container') {
          steps {
            echo 'Running new image...'
            sh """
              docker run -p 8088:8080 \
                -e MYSQL_ROOT_PASSWORD=${MYSQL_CRED_PSW} \
                -e MYSQL_USER=${MYSQL_CRED_USR} \
                -d ${IMAGE_NAME}:latest
             """
          }
        }
    }
    post {
      success {
        echo 'Deploy Succeeded'
      }
    }
}
