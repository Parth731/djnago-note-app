@Library('shared') _
pipeline {
    agent { label 'vinod' }

    stages {
        stage('Cleanup') {
            steps {
                script {
                    echo "Cleaning up unused Docker resources"
                    sh 'docker-compose down || true'  // Take down existing containers (ignore errors if none exist)
                    sh 'docker system prune -a -f --volumes'  // Cleanup all unused resources
                }
            }
        }
        stage('Clone Code') {
            steps {
                script {
                    echo "Cloning the code repository"
                    git url: 'https://github.com/Parth731/djnago-note-app.git', branch: 'parth-dev'
                    echo "Code cloned successfully"
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "Building the Docker image"
                    sh 'docker build --no-cache -t parth731/notes-app:latest .'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Pushing the image to Docker Hub"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'docker login -u $USERNAME -p $PASSWORD'
                        sh 'docker push parth731/notes-app:latest'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Deploying the application using Docker Compose"
                    // sh 'docker-compose pull'  // Ensure the latest image is pulled
                    // sh 'docker-compose up -d --force-recreate'  // Force recreate containers to avoid stale configs
                    sh 'docker-compose down && docker-compose up -d'
                }
            }
        }
    }
}
