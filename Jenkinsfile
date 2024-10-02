pipeline {
    agent any
    environment {
        dockerRegistry = "https://index.docker.io/v1/"
        dockerCreds = credentials('dockerhub-credentials')  // Docker Hub credentials
        awsAccountId = '211125559768'
        awsRegion = 'ap-south-1'
        ecrRepository = 'devsecops'
        dockerImage = 'practical:devsecops'
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
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerfilePath = "." // Path to the Dockerfile
                    bat "docker build -f Dockerfile -t sureshnangina/${dockerImage} ${dockerfilePath}"
                }
            }
        }
        stage('Push Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry(dockerRegistry, 'dockerhub-credentials') {
                        echo "Pushing image to Docker Hub"
                        bat "docker push sureshnangina/${dockerImage}"
                    }
                }
            }
        }
        stage('Login to AWS ECR') {
            steps {
                script {
                    // Authenticate Docker with AWS ECR
                    bat "aws ecr get-login-password --region ${awsRegion} | docker login --username AWS --password-stdin ${awsAccountId}.dkr.ecr.${awsRegion}.amazonaws.com"
                }
            }
        }
        stage('Tag Image for AWS ECR') {
            steps {
                script {
                    // Tag the image with AWS ECR repository URI
                    bat "docker tag sureshnangina/${dockerImage} ${awsAccountId}.dkr.ecr.${awsRegion}.amazonaws.com/${ecrRepository}:latest"
                }
            }
        }
        stage('Push Image to AWS ECR') {
            steps {
                script {
                    // Push the Docker image to AWS ECR
                    bat "docker push ${awsAccountId}.dkr.ecr.${awsRegion}.amazonaws.com/${ecrRepository}:latest"
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
