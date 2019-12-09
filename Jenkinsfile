pipeline {
    agent none
    environment {
        CI = 'true'
        registry = "dockerismypal/devops"
        dockerImage = ''
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
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
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
        stage('Push image') {
            steps{
                script{
                    docker.withRegistry('', 'docker-hub-credentials') {
                                dockerImage.push()
                    }
                }
            }
        }
    }
}