// Jenkinsfile
pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "my-calculator-app"
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Setup') {
            steps {
                echo "Setting up Python environment and installing dependencies"
                sh '''
                    python3 --version
                    pip3 install -r requirements.txt --break-system-packages
                '''
            }
        }
        
        stage('Test') {
            steps {
                echo "Running tests with pytest"
                sh 'python3 -m pytest test.py -v'
            }
        }
        
        stage('Run App') {
            steps {
                echo "Application is ready to run"
                sh 'echo "Calculator app is working! Tests passed successfully."'
            }
        }
        
        stage('Deploy') {
            steps {
                echo "Building container image...."
                sh "docker buid -t ${env.DOCKER_IMAGE}${env.DOCKER_TAG} ."
                // script {
                //     if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') {
                //         echo "🚀 Deploying to PRODUCTION environment"
                //         echo "All calculator functions are available in production!"
                //     } else if (env.BRANCH_NAME == 'staging') {
                //         echo "🔄 Deploying to STAGING environment" 
                //         echo "Testing calculator functions in staging before production"
                //     } else if (env.BRANCH_NAME == 'dev' || env.BRANCH_NAME.startsWith('feature/')) {
                //         echo "🔧 Deploying to DEVELOPMENT environment"
                //         echo "Calculator is ready for development testing"
                //     } else {
                //         echo "📦 Building for branch: ${env.BRANCH_NAME}"
                //         echo "Calculator built successfully"
                //     }
                // }
            }
        }
    }
    
    post {
        always {
            slackSend channel: '#jenkins-notifications', color: 'warn', message: 'Pipeline finished for branch: ${env.BRANCH_NAME}!!!'
        }
        success {
            slackSend channel: '#jenkins-notifications', color: 'good', message: '✅ Build successful! Calculator is working perfectly.'
        }
        failure {
            slackSend channel: '#jenkins-notifications', color: 'danger', message: '❌ Build failed. Please check the logs and fix any issues.'
        }
    }
}
