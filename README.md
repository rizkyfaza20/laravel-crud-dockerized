# Laravel CRUD Docker integration

This repository contains of the CRUD integration with containerization features.

The explanation of the CRUD integration, including the configuration of Jenkins integration CI/CD was listed below : 
 - Jenkinsfile contains the settings for to build the docker image
 - Next will be push to the dockerhub repository
 - And finally deploy the app to the Kubernetes locally.

And also contains the Dockerfile that also creates images for the CRUD Apps.

The CRUD Application port was mapped to the 8000, after deployment to the Kubernetes will serve to the 30001.

The Kubernetes file was contain Deployment also Services to serve the application.
