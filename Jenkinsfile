pipeline {
    agent any
    environment {
        dockerRegistry = "https://index.docker.io/v1/"
        dockerCreds = credentials('dockerhub-credentials')  // Your Docker Hub credentials
        nginxImage = 'nginx-image'
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
                    def nginxPath = "portfol" // Update this path to the directory containing your Dockerfile
                    def dockerfileNginx = "portfol/Dockerfile" // Dockerfile path
                    bat "docker build -f ${dockerfileNginx} -t sureshnangina/nginx-image:latest ${nginxPath}"
                }
            }
        }
        stage('Push NGINX Image') {
            steps {
                script {
                    docker.withRegistry(dockerRegistry, 'dockerhub-credentials') {
                        echo "Pushing NGINX image to Docker Hub"
                        bat "docker push sureshnangina/nginx-image:latest"
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
