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
                    sh '''
                    sonar-scanner \
                    -Dsonar.projectKey=kumarsuresh03_CA3 \
                    -Dsonar.organization=kumarsuresh03 \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=https://sonarcloud.io \
                    -Dsonar.login=$SONAR_TOKEN
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t sureshnangina/devsecops:latest .'
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                script {
                    sh 'trivy image --exit-code 1 --severity HIGH yourusername/yourimage:latest'
                }
            }
        }

        stage('Push to Docker Hub') {
            environment {
                DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
            }
            steps {
                script {
                    sh '''
                    echo $DOCKER_HUB_CREDENTIALS | docker login -u yourusername --password-stdin
                    docker push sureshnangina/devsecops:latest
                    '''
                }
            }
        }


    }
}
