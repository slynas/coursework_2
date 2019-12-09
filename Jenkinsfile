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
        stage('Push image') {
            steps{
                script{
                    docker.withRegistry('https://hub.docker.com/repository/docker/dockerismypal/devops', 'docker-hub-credentials') {
                                app = docker.build("coursework_2")
                                app.push("${env.BUILD_NUMBER}")
                                app.push("latest")
                    }
                }
            }
        }
    }
}