pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/kumarsuresh03/portfol.git'
            }
        }
        stage('SonarCloud Analysis') {
            environment {
                SONAR_TOKEN = credentials('sonarcloud-token')
            }
            steps {
                bat '''
                sonar-scanner.bat ^
                -Dsonar.projectKey=kumarsuresh03_CA3 ^
                -Dsonar.organization=kumarsuresh03 ^
                -Dsonar.sources=. ^
                -Dsonar.host.url=https://sonarcloud.io ^
                -Dsonar.login=%SONAR_TOKEN%
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t sureshnangina/devsecops:latest .'
            }
        }
        stage('Trivy Scan') {
            steps {
                bat 'trivy image --exit-code 1 --severity HIGH sureshnangina/devsecops:latest'
            }
        }
        stage('Push to Docker Hub') {
            environment {
                DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    bat 'echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin'
                    bat 'docker push sureshnangina/devsecops:latest'
                }
            }
        }
    }
}
