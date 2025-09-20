@Library('python-shared-library') _

pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "my-calculator-app"
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('checkout'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-key', url: 'https://github.com/hkm7/calculator-application']])
            }
        }
        stage('Install dependencies') {
            steps {
                install_dependencies()
            }
        }
        stage('Test') {
            steps {
                test()
            }
        }
        stage('deploy') {
            steps {
              sh "docker build -t myapp ."
                // def image = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                // sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
                // docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
            }
        }
        // stage('Test Image') {
        //     // steps {
        //     //     // script {
        //     //     //     // Run basic tests on the image
        //     //     //     sh """
        //     //     //         docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} echo "Image test successful"
        //     //     //     """
        //     //     // }
        //     // }
        // }
    }
    post {
        always {
            echo "🧹 Cleaning up workspace..."
            cleanWs()
        }
        success {
            echo "✅ Python Calculator pipeline completed successfully!"
        }
        failure {
            echo "❌ Python Calculator pipeline failed!"
        }
    }
}
