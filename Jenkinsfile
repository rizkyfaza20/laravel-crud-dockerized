pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "docker.io"
        DOCKER_IMAGE_NAME = "laravel-crud-backend"
        DOCKER_FILE_PATH = "."
        KUBERNETES_NAMESPACE = "laravel-crud-backend"
        KUBERNETES_DEPLOYMENT_NAME = "laravel-crud-deployment"
        KUBERNETES_CONTAINER_NAME = "laravel-crud-backend"
        DOCKERHUB_CREDENTIALS = credentials('9761b7f3-55ac-4c3e-adeb-d35d9b44dcc0')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build \
                    --no-cache \
                    --pull \
                    --rm \
                    -f ${DOCKER_FILE_PATH}/Dockerfile \
                    -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} \
                    ${DOCKER_FILE_PATH}/.
                '''
            }
        }
        stage('Push Docker Image') {
            steps {
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    sh '''
                        docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}
                    '''
                }
            }
        stage('Deploy to Kubernetes on Localhost') {
            steps {
                script {
                    node('master') {
                        stage('Deploy') {
                            sh '''
                                kubectl config use-context docker-for-desktop
                                kubectl set image deployment/${KUBERNETES_DEPLOYMENT_NAME} ${KUBERNETES_CONTAINER_NAME}=${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} -n ${KUBERNETES_NAMESPACE}
                            '''
                        }
                    }
                }
            }
        }
    }
}
