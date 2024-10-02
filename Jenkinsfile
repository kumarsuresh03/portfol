pipeline {
    agent any
    environment {
        dockerRegistry = "https://index.docker.io/v1/"
        dockerCreds = credentials('dockerhub-credentials')  // Your Docker Hub credentials
        nginxImage = 'devsecops'
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/kumarsuresh03/portfol.git'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry(dockerRegistry, 'dockerhub-credentials') {
                        echo "Logged in to Docker Hub"
                    }
                }
            }
        }
        stage('Build NGINX Image') {
            steps {
                script {
                    def nginxPath = "." // Path to the current directory containing your Dockerfile
                    def dockerfileNginx = "Dockerfile" // Dockerfile path in the root directory
                    bat "docker build -f ${dockerfileNginx} -t sureshnangina/devsecops:latest ${nginxPath}"
                }
            }
        }
        stage('Push NGINX Image') {
            steps {
                script {
                    docker.withRegistry(dockerRegistry, 'dockerhub-credentials') {
                        echo "Pushing NGINX image to Docker Hub"
                        bat "docker push sureshnangina/devsecops:latest"
                    }
                }
            }
        }

    }
    post {
        always {
            echo 'Pipeline completed'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
