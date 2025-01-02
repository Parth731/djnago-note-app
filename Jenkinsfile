
@Library('shared') _
pipeline {
    agent { label 'vinod' }
    
    stages {
        //shared library
        stage('Hello') {
            steps {
                script {
                    hello()
                    sh 'docker volume prune -f'
                    sh 'docker container prune -f'
                    sh 'docker image prune -f'
                }
            }
        }
        stage('code') {
            steps {
                echo 'this is cloning the code'
                git url: 'https://github.com/Parth731/djnago-note-app.git', branch: 'parth-dev'
                echo 'code is clone successfully'
            }
        }
        stage('Build') {
            steps {
                echo 'This is building the code'
                sh 'whoami'
                sh 'docker build -t notes-app:latest .'

            }
        }
        stage('Test') {
            steps {
                echo 'This is testing the code'
            }
        }
        stage('push to docker hub') {
            steps {
                echo 'this is pushing the code to docker hub'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker tag notes-app:latest $USERNAME/notes-app:latest'
                    sh 'docker push $USERNAME/notes-app:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'This is deploy the code'
                // sh 'docker run -d -p 8000:8000 note-app:latest'
                sh 'docker-compose up -d'
            }
        }
    }
}