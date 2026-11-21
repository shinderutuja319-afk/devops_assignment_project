# Wisecow Application – DevOps Automation Project

A containerized Wisecow application deployed on Kubernetes with automated CI/CD using GitHub Actions and HTTPS enabled using Let's Encrypt.

## Project Overview

This project demonstrates an end-to-end DevOps workflow, including Docker containerization, Kubernetes deployment, automated image building and deployment, and SSL/TLS configuration.

## Architecture

```text
             Developer
                 |
                 v
          GitHub Repository
                 |
                 v
          GitHub Actions
           CI/CD Pipeline
                 |
          Build Docker Image
                 |
                 v
             Docker Hub
                 |
                 v
          Deploy to Kubernetes
                 |
                 v
          Kubernetes Cluster
           (2 Replicas)
                 |
                 v
          Kubernetes Service
             (NodePort)
                 |
                 v
              Nginx
                 |
           HTTPS / TLS
                 |
          Let's Encrypt
                 |
                 v
          Wisecow Application
```

## Technologies Used

- AWS EC2 – Cloud hosting
- Docker – Application containerization
- Docker Hub – Container image registry
- Kubernetes – Container orchestration
- Minikube – Local/EC2-hosted Kubernetes cluster
- GitHub Actions – CI/CD automation
- Nginx – Reverse proxy
- DuckDNS – Free domain
- Let's Encrypt / Certbot – SSL/TLS certificate
- Ubuntu Linux – Server operating system
- Bash – Shell scripting

## Key Implementations

### 1. Docker Containerization
- Created a Dockerfile for the Wisecow application.
- Installed application dependencies.
- Built and tested the Docker image.
- Published the image to Docker Hub.

### 2. Kubernetes Deployment
- Created Kubernetes Deployment configuration.
- Configured two application replicas.
- Exposed the application using a NodePort Service.
- Configured readiness and liveness probes.
- Defined container resource requests and limits.

### 3. CI/CD Automation
Implemented GitHub Actions to:
- Build the Docker image automatically.
- Push versioned and latest images to Docker Hub.
- Deploy updated images to the Kubernetes cluster through SSH.
- Verify rollout status after deployment.

### 4. HTTPS / SSL Configuration
- Configured a free DuckDNS domain.
- Installed Nginx as a reverse proxy.
- Configured Let's Encrypt SSL/TLS using Certbot.
- Enabled HTTPS access.
- Configured automatic certificate renewal.

## Live Application

**HTTPS:** https://wise-demo.duckdns.org

Note: The live URL depends on the AWS EC2 instance remaining active.

## Repository Structure

```text
devops_assignment_project/
│
├── .github/
│   └── workflows/
│       └── ci-cd.yml
│
└── wisecow/
    ├── Dockerfile
    ├── wisecow.sh
    ├── README.md
    └── k8s/
        ├── deployment.yml
        └── service.yml
```

## What I Learned

- Containerizing applications using Docker.
- Deploying and managing workloads in Kubernetes.
- Configuring Kubernetes Services and health probes.
- Automating CI/CD pipelines using GitHub Actions.
- Pushing container images to Docker Hub.
- Configuring Nginx reverse proxy.
- Enabling HTTPS using Let's Encrypt and Certbot.
- Managing cloud infrastructure on AWS EC2.

## Author

**Rutuja Shinde**

Cloud & DevOps Engineer | MCA 2026

GitHub: https://github.com/shinderutuja319-afk
