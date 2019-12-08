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
            ws ('ws/sonar-server.properties'){
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
}