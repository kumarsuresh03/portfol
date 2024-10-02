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
                script {
                    // Use 'bat' for Windows compatibility
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
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Use 'bat' for Docker build command on Windows
                    bat 'docker build -t sureshnangina/devsecops:latest .'
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                script {
                    // Use 'bat' for Trivy scan command on Windows
                    bat 'trivy image --exit-code 1 --severity HIGH sureshnangina/devsecops:latest'
                }
            }
        }

        stage('Push to Docker Hub') {
            environment {
                DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
            }
            steps {
                script {
                    // Use 'bat' for Docker login and push commands on Windows
                    bat '''
                    echo %DOCKER_HUB_CREDENTIALS% | docker login -u yourusername --password-stdin
                    docker push sureshnangina/devsecops:latest
                    '''
                }
            }
        }
    }
}
