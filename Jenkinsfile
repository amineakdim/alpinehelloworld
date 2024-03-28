pipeline {
    agent any
    stages {
        stage('build') {
            steps {
              sh 'docker build -t alpine_test .'
            }
            
        }
        stage('run') {
            steps {
              sh 'docker run --name test_alpine -p 8989:5000 -d -e PORT=5000 alpinehelloworld:latest'
            }
            
        }
    }
}
