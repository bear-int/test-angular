pipeline {
    agent any
    environment {
        PROJECT_ID = 'vocal-framework-271111'
        DOCKER_IMAGE = 'test-angular'
        LOCATION = 'CLUSTER-LOCATION'
        GOOGLE_SERVICE_ACCOUNT_KEY = credentals('vocal-framework-271111');
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
        stage("Build image") {
            steps {
                script {
                    app = docker.build("gcr.io/$PROJECT_ID/$DOCKER_IMAGE:latest")
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://gcr.io', 'gcr:vocal-framework-271111') {
                            myapp.push("latest")
                    }
                }
            }
        }        
    }    
}
