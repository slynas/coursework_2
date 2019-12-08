pipeline {
    agent none
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            agent any
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