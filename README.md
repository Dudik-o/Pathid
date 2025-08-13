# PathID Assignment

This repository demonstrates an end-to-end local Kubernetes deployment pipeline using GitHub Actions, Terraform, and Kind (Kubernetes in Docker).

## GitHub Actions Flow

The workflow (`.github/workflows/deploy.yml`) automates the process of creating a Kubernetes cluster locally, building application images, and deploying them.

### Trigger
- `workflow_dispatch` – The workflow is manually triggered from GitHub.

### Steps Overview

1. **Checkout Source Code**  
   Pulls the repository into the runner to access Terraform code, Dockerfile, and Kubernetes manifests.

2. **Setup Terraform**  
   Installs Terraform (`v1.5.7`) for infrastructure provisioning.

3. **Install Kind & Kubectl** (Act local runs only)  
   Installs `kind` CLI to allow creating Kubernetes clusters inside the GitHub Actions runner.  
   Installs `kubectl` for interacting with the cluster.

4. **Build Docker Image**  
   Builds the Node.js application Docker image (`pod-echo:<tag>`) directly in the workflow.

5. **Terraform Init / Plan / Apply**  
   Initializes Terraform in the defined directory, plans infrastructure creation, and applies the plan automatically to create and configure the cluster and applications.

## What Terraform Creates

Terraform provisions the complete local Kubernetes environment in Kind.

### 1. Kubernetes Cluster
- Control Plane Node – Handles Kubernetes API, scheduling, and cluster control.
- Worker Node – Runs workloads and services.

### 2. NGINX Ingress Controller
- Deployed to manage incoming HTTP/S traffic.
- Routes requests to applications inside the cluster.

### 3. Applications

#### Podinfo
- A demo microservice deployed using the [stefanprodan/podinfo](https://github.com/stefanprodan/podinfo) Helm chart.
- Useful for testing deployments, service routing, and ingress.
- provides an `/podinfo` endpoint, accessible via `http://localhost/podinfo`
#### Node.js Application (Pod Echo)
- Built inside this pipeline from the Dockerfile in the repository.
- Displays the Pod name and Pod ID in the response. 
- Includes a `/health` endpoint, designed for future use as a readiness probe in Kubernetes.  
  This path can later be referenced in a `readinessProbe` configuration to ensure the pod is ready before accepting traffic.
- Provides an `/info` endpoint, accessible via `http://localhost/info`

## Local Development & Testing

You can run this pipeline locally using [Act](https://github.com/nektos/act):

```bash
act workflow_dispatch \
  -W .github/workflows/deploy.yml \
  -P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest \
  --container-architecture linux/amd64
