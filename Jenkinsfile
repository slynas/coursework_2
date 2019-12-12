pipeline {
    agent none
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            agent {
                    docker {
                        image 'node:6-alpine'
                        args '-p 3000:3000'
                    }
                }
            steps {
                sh 'npm install'
            }
        }
        stage('Sonarqube') {
            agent any
            environment {
                scannerHome = tool 'SonarQubeScanner'
            }
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}

node {
    def app

   stage('Build image') {
        app = docker.build("dockerismypal/devops")
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Rolling Update'){
        sh 'ssh azureuser@40.117.171.112

            kubectl set image deployments/devops devops=dockerismypal/devops:latest

            sleep 30s

            export NODE_PORT=$(kubectl get services/node-port-service -o go-template='{{(index .spec.ports 0).nodePort}}')

            curl $(minikupe ip):$NODE_PORT'
    }
}