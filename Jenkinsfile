pipeline {
    agent any
    triggers {
      githubPush()
    }
    environment {
        IMAGE_NAME = 'nikpolik/newwebapp'
        DB_IMAGE_NAME = 'nikpolik/mysql'
        RUNNING_CONTAINERS = sh (
                  script: 'docker ps -a -q | xargs',
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
        stage ('Build Docker Images') {
          steps {
            echo 'Login in to dockerhub...'
            sh "docker login -u ${DOCKER_CRED_USR} -p ${DOCKER_CRED_PSW}"
            echo 'Building webapp Image...'
            sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            sh "docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"
            echo 'Publishing web app image...'
            sh "docker push ${IMAGE_NAME}"
            echo 'Building db image'
            dir('database') {
              sh "docker build -t ${DB_IMAGE_NAME}:${BUILD_NUMBER} ."
              sh "docker tag ${DB_IMAGE_NAME}:${BUILD_NUMBER} ${DB_IMAGE_NAME}:latest"
              sh "docker push ${DB_IMAGE_NAME}"
            }
          }
        }
        stage('Deploy Database Container') {
          steps {
            sh """
              docker run -p 3306:3306 --name mysql-server \
                -e MYSQL_ROOT_PASSWORD=${MYSQL_CRED_PSW} \
                -d ${DB_IMAGE_NAME}:latest
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
