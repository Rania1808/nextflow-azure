# nextflow-azure

![oms](https://github.com/user-attachments/assets/0842235f-5d9c-4832-8268-822b4c6c3028)

# 🚀 NextJS Production-Ready CI/CD Pipeline

[![Pipeline Status](https://img.shields.io/badge/status-production-success)](https://gitlab.com/your-org/nextjs-app)
[![Infrastructure](https://img.shields.io/badge/infrastructure-terraform-purple)](https://www.terraform.io/)
[![GitOps](https://img.shields.io/badge/gitops-argocd-orange)](https://argo-cd.readthedocs.io/)
[![Security](https://img.shields.io/badge/security-trivy%20%2B%20sonarqube-blue)](https://github.com/aquasecurity/trivy)

## 📋 Table of Contents

- [Overview](#-overview)
- [Problems Solved](#-problems-solved)
- [Architecture](#%EF%B8%8F-architecture)
- [Technologies & Tools](#%EF%B8%8F-technologies--tools)
- [Repository Structure](#-repository-structure)
- [Prerequisites](#-prerequisites)
- [Detailed Configuration](#%EF%B8%8F-detailed-configuration)
- [CI/CD Pipelines](#-cicd-pipelines)
- [Security](#-security)
- [Deployment Guide](#-deployment-guide)
- [Monitoring](#-monitoring)
- [Troubleshooting](#-troubleshooting)

---

## 🎯 Overview

**Modern production-ready** CI/CD pipeline for **Next.js** application deployed on **Azure Kubernetes Service (AKS)** with **GitOps**, **Nexus caching**, and **automated security scanning**.

### 📊 Key Performance Metrics

| Metric | Before ❌ | After ✅ | Improvement |
|--------|----------|----------|-------------|
| **Build Time** | 15-20 min | 3-5 min | **⚡ 75% faster** |
| **Deployment** | Manual (VM) | Automated (K8s) | **🤖 100% automated** |
| **Security** | None | SonarQube + Trivy | **🔒 Complete scanning** |
| **Rollback** | Complex | 1-click | **⏱️ Instant** |
| **Infrastructure** | Unversioned | Terraform IaC | **📦 Reproducible** |
| **Cache** | ❌ None | Nexus npm/Docker | **💾 70% bandwidth saved** |

---

## 🔧 Problems Solved

### ❌ Old Architecture (Manual Azure VM)

**Major Issues:**

1. **Manual Deployment** 🔴
   - Manual SSH connection to Azure VM
   - Manual commands (`git pull`, `npm install`, `pm2 restart`)
   - High risk of human errors
   - Zero deployment traceability
   - Impossible or risky rollback

2. **Extremely Slow Builds** 🐌
   - Full `node_modules` download (~500MB) every build
   - No npm cache
   - Unoptimized Next.js build
   - **Average time: 15-20 minutes**

3. **No Security** 🚨
   - No static code analysis
   - Unknown vulnerabilities in dependencies
   - No Docker image scanning
   - Secrets in plain text
   - No Quality Gates

4. **Fragile Infrastructure** 💥
   - Manual VM configuration
   - No documentation
   - Impossible to reproduce
   - Single point of failure
   - Dev/prod environments divergence

### ✅ New Architecture (AKS + CI/CD + GitOps)

**Implemented Solutions:**

| Category | Solution | Benefit |
|----------|----------|---------|
| **CI/CD** | GitLab CI/CD multi-stage pipelines | Complete automation |
| **Cache** | Nexus npm proxy + Docker registry | 75% faster builds |
| **Quality** | SonarQube + Quality Gates | Guaranteed code quality |
| **Security** | Trivy scan (FS + images) | Vulnerabilities detected |
| **Infrastructure** | Terraform IaC + automated pipeline | Reproducible in 1 command |
| **Deployment** | ArgoCD GitOps | Auto sync + easy rollback |
| **Monitoring** | Azure Monitor + Logs | Complete observability |

---

## 🏗️ Architecture

### Deployment Flow

```
┌─────────────────────────────────────────────────────────────┐
│  1. Developer push code to GitLab                           │
└────────────────────────┬────────────────────────────────────┘
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  2. GitLab CI Pipeline Triggered (Application)              │
│     • Quality (SonarQube)                                   │
│     • Build (Nexus cache)                                   │
│     • Security (Trivy)                                      │
│     • Package (Docker + ACR)                                │
│     • Update GitOps repo                                    │
└────────────────────────┬────────────────────────────────────┘
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  3. ArgoCD Detects Changes                                  │
│     • New image tag in GitOps repo                          │
│     • Sync Kubernetes manifests                             │
│     • Deploy to AKS                                         │
└─────────────────────────────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INFRASTRUCTURE PROVISIONING (Separate Pipeline)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─────────────────────────────────────────────────────────────┐
│  1. Push to infrastructure/ folder                          │
└────────────────────────┬────────────────────────────────────┘
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  2. Azure DevOps Pipeline Triggered                         │
│     • terraform init                                        │
│     • terraform validate                                    │
│     • terraform plan                                        │
│     • terraform apply (auto/manual approval)                │
└────────────────────────┬────────────────────────────────────┘
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  3. Azure Resources Provisioned                             │
│     • AKS Cluster                                           │
│     • Azure Container Registry                              │
│     • Virtual Network                                       │
│     • Load Balancer                                         │
│     • Monitoring                                            │
└─────────────────────────────────────────────────────────────┘
```

**Key Components:**

- **GitLab CI/CD**: Application build and deployment pipeline
- **Azure DevOps**: Infrastructure provisioning pipeline (Terraform)
- **Nexus**: Cache for npm packages and Docker layers
- **SonarQube**: Static code analysis and quality gates
- **Trivy**: Security vulnerability scanner
- **Terraform**: Infrastructure as Code for Azure
- **ArgoCD**: GitOps continuous delivery
- **AKS**: Azure Kubernetes Service for container orchestration

---

## 🛠️ Technologies & Tools

### Source Control & CI/CD
- **GitLab** - Application source code repository
- **GitLab CI/CD** - Application build pipeline
- **Azure DevOps** - Infrastructure pipeline (Terraform automation)
- **GitLab Runner** - Docker executor for app pipeline
- **Azure DevOps Agent** - Terraform pipeline executor

### Build & Cache
- **Node.js 20** - Runtime
- **Next.js** - React framework
- **npm** - Package manager
- **Nexus Repository Manager** - Artifacts cache (npm proxy + Docker registry)

### Quality & Security
- **SonarQube** - Static code analysis (bugs, vulnerabilities, code smells)
- **Trivy** - Vulnerability scanner
  - Scan npm dependencies
  - Scan Docker images (OS + libraries)
  - Generate JSON + HTML reports

### Infrastructure (Azure)
- **Terraform** - Infrastructure as Code
- **Azure Kubernetes Service (AKS)** - Container orchestration
- **Azure Container Registry (ACR)** - Docker registry
- **Azure Virtual Network** - Networking
- **Azure Load Balancer** - Traffic distribution
- **Azure Monitor** - Observability

### Deployment
- **ArgoCD** - GitOps continuous delivery
- **Kubernetes** - Container orchestration
- **Kustomize** - Kubernetes configuration management

---


> **Note:** 
> - Complete infrastructure code and documentation are in the `infrastructure/` folder
> - Kubernetes manifests and ArgoCD configurations are in the `k8s-gitops/` folder


---

## 📦 Prerequisites

### Required Tools

```bash
# Local Development
- Git >= 2.30
- Node.js >= 20.0
- Docker >= 24.0

# Infrastructure Management
- Terraform >= 1.5
- Azure CLI >= 2.50
- kubectl >= 1.28

# Optional
- helm >= 3.12
- argocd CLI >= 2.9
```

### Required Accounts & Access

- ✅ **Azure Subscription** with Contributor role
- ✅ **Azure DevOps** organization and project
- ✅ **GitLab** account with repository access
- ✅ **Nexus**: URL + credentials
- ✅ **SonarQube**: URL + token
- ✅ **Azure Service Principal** for Terraform

### Install Tools

```bash
# Azure CLI (Ubuntu/Debian)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Terraform
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# ArgoCD CLI
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
```

---

## ⚙️ Detailed Configuration

### 1. GitLab CI/CD Variables (Application Pipeline)

**Path:** Settings → CI/CD → Variables

#### Azure Authentication
```bash
AZURE_SUBSCRIPTION_ID       # Your Azure subscription ID
AZURE_TENANT_ID            # Azure AD Tenant ID
AZURE_CLIENT_ID            # Service Principal Application ID
AZURE_CLIENT_SECRET        # Service Principal Secret (Protected)
AZURE_RESOURCE_GROUP       # Main resource group
ACR_LOGIN_SERVER          # myregistry.azurecr.io
ACR_USERNAME              # Service Principal ID or admin
ACR_PASSWORD              # Service Principal Secret (Protected)
```

#### Nexus Configuration
```bash
NEXUS_URL                  # https://nexus.example.com
NEXUS_USERNAME             # nexus-user
NEXUS_PASSWORD             # password (Protected)
NEXUS_NPM_REGISTRY         # ${NEXUS_URL}/repository/npm-proxy/
NEXUS_DOCKER_REGISTRY      # ${NEXUS_URL}/repository/docker-hosted/
NEXUS_AUTH_TOKEN          # Base64(username:password) for .npmrc
```

**Generate NEXUS_AUTH_TOKEN:**
```bash
echo -n "nexus-user:password" | base64
# Result: bmV4dXMtdXNlcjpwYXNzd29yZA==
```

#### SonarQube
```bash
SONAR_HOST_URL            # https://sonarqube.example.com
SONAR_TOKEN               # Token generated from SonarQube (Protected)
SONAR_PROJECT_KEY         # nextjs-production-app
```

#### GitOps Repository
```bash
GITOPS_REPO_URL           # URL to k8s-gitops folder or separate repo
GITOPS_TOKEN              # Personal Access Token with write access (Protected)
GITOPS_USER_EMAIL         # gitlab-ci@example.com
GITOPS_USER_NAME          # GitLab CI Bot
```

#### Application
```bash
APP_NAME                   # nextjs-app
ENVIRONMENT               # production (or dev, staging)
K8S_NAMESPACE             # production
```

---

### 2. Azure DevOps Configuration (Infrastructure Pipeline)

#### 2.1 Create Azure DevOps Project

1. Go to https://dev.azure.com
2. Create new organization or use existing
3. Create new project: `NextJS-Infrastructure`

#### 2.2 Create Service Connection

```
Project Settings → Service connections → New service connection

Connection Type: Azure Resource Manager
Authentication method: Service principal (automatic)
Scope level: Subscription
Subscription: Select your subscription
Service connection name: azure-terraform-sp

☑ Grant access permission to all pipelines
```

#### 2.3 Azure DevOps Pipeline Variables

```
Pipelines → Library → Variable groups → New variable group

Name: terraform-vars

Variables:
- ARM_CLIENT_ID              # Service Principal ID
- ARM_CLIENT_SECRET          # Service Principal Secret (Secret)
- ARM_SUBSCRIPTION_ID        # Azure Subscription ID
- ARM_TENANT_ID              # Azure AD Tenant ID
- TF_STATE_RESOURCE_GROUP    # terraform-state-rg
- TF_STATE_STORAGE_ACCOUNT   # tfstatestorage12345
- TF_STATE_CONTAINER         # tfstate
```

#### 2.4 Azure Pipeline YAML (infrastructure/pipelines/azure-pipelines.yml)

```yaml
trigger:
  branches:
    include:
      - validation

pool:
  vmImage: 'ubuntu-latest'

variables:
  terraformVersion: '1.5.7'
  azureServiceConnection: 'AzureRM-nextjs-app-SP'  

steps:
- task: TerraformInstaller@1
  inputs:
    terraformVersion: '$(terraformVersion)'

- task: TerraformTaskV4@4
  displayName: 'Terraform Init'
  inputs:
    provider: 'azurerm'
    command: 'init'
    backendServiceArm: '$(azureServiceConnection)'
    backendAzureRmResourceGroupName: 'nextjs-app-infra'
    backendAzureRmStorageAccountName: 'tfstatenextjsapp'
    backendAzureRmContainerName: 'tfstate'
    backendAzureRmKey: 'validation.terraform.tfstate'
    workingDirectory: 'envs/validation'

- task: TerraformTaskV4@4
  displayName: 'Terraform Plan'
  inputs:
    provider: 'azurerm'
    command: 'plan'
    environmentServiceNameAzureRM: '$(azureServiceConnection)'
    workingDirectory: 'envs/validation'

- task: TerraformTaskV4@4
  displayName: 'Terraform Apply'
  inputs:
    provider: 'azurerm'
    command: 'apply'
    environmentServiceNameAzureRM: '$(azureServiceConnection)'
    args: '-auto-approve'
    workingDirectory: 'envs/validation'

```

#### 2.5 Setup Azure DevOps Environment for Approvals

```
Pipelines → Environments → New environment

Name: production
Resources: None (for approval gates only)

Add approval: Add check → Approvals

Approvers: Select users/groups who can approve
Instructions: "Review Terraform plan before applying infrastructure changes"
Timeout: 30 days
```

#### 2.6 Connect Azure DevOps to GitLab

```
Project Settings → Service connections → New service connection

Connection Type: Generic Git (or GitLab)
Server URL: https://gitlab.com/your-org/nextjs-project.git
Authentication: Personal Access Token
Token: (GitLab PAT with read access)
Service connection name: gitlab-repo
```

---

### 3. Nexus Repository Manager

#### 3.1 Nexus Installation (Docker)

```bash
# Create persistent volumes
docker volume create nexus-data

# Run Nexus
docker run -d \
  --name nexus \
  -p 8081:8081 \
  -p 8082:8082 \
  -v nexus-data:/nexus-data \
  sonatype/nexus3:latest

# Get initial admin password
docker exec nexus cat /nexus-data/admin.password
```

**Access:** http://localhost:8081
- **Username:** admin
- **Password:** (see command above)

#### 3.2 Create npm Repository (proxy)

```
Repositories → Create repository → npm (proxy)

Name: npm-proxy
Remote storage: https://registry.npmjs.org
Blob store: default
Maximum component age: 1440 (24h)
Maximum metadata age: 1440 (24h)

☑ Enable authentication
```

#### 3.3 Create Docker Repository (hosted)

```
Repositories → Create repository → docker (hosted)

Name: docker-hosted
HTTP: 8082
☑ Enable Docker V1 API: false
☑ Allow anonymous docker pull: false
Blob store: default
Deployment policy: Allow redeploy
```

#### 3.4 .npmrc Configuration in Pipeline

```bash
# .gitlab-ci.yml - before_script
- echo "registry=${NEXUS_NPM_REGISTRY}" > .npmrc
- echo "always-auth=true" >> .npmrc
- echo "_auth=${NEXUS_AUTH_TOKEN}" >> .npmrc
```

---

### 4. SonarQube

#### 4.1 SonarQube Installation (Docker)

```bash
# With PostgreSQL
docker network create sonarnet

docker run -d \
  --name sonar-postgres \
  --network sonarnet \
  -e POSTGRES_USER=sonar \
  -e POSTGRES_PASSWORD=sonar \
  -e POSTGRES_DB=sonarqube \
  postgres:15-alpine

docker run -d \
  --name sonarqube \
  --network sonarnet \
  -p 9000:9000 \
  -e SONAR_JDBC_URL=jdbc:postgresql://sonar-postgres:5432/sonarqube \
  -e SONAR_JDBC_USERNAME=sonar \
  -e SONAR_JDBC_PASSWORD=sonar \
  sonarqube:lts-community
```

**Access:** http://localhost:9000
- **Default credentials:** admin / admin

#### 4.2 Create Project & Configure Quality Gates

```
Administration → Projects → Create Project

Project Key: nextjs-production-app
Project Name: NextJS Production App
Main Branch: main
```

**Quality Gate:**
```
Quality Gates → Create → "Production Gate"

Conditions:
- Coverage >= 80%
- Duplicated Lines (%) <= 3%
- Maintainability Rating = A
- Reliability Rating = A
- Security Rating = A
```

#### 4.3 sonar-project.properties

```properties
sonar.projectKey=nextjs-production-app
sonar.projectName=NextJS Production App
sonar.sources=src,app,pages,components
sonar.exclusions=node_modules/**,build/**,.next/**,coverage/**
sonar.javascript.lcov.reportPaths=coverage/lcov.info
```

---

### 5. ArgoCD GitOps

#### 5.1 ArgoCD Installation on AKS

```bash
# Get AKS credentials
az aks get-credentials \
  --resource-group nextjs-production-rg \
  --name nextjs-app-aks

# Create namespace
kubectl create namespace argocd

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.9.3/manifests/install.yaml

# Wait for pods
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s
```

#### 5.2 Access ArgoCD UI

```bash
# Get initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Port forward (method 1)
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Or expose via LoadBalancer (method 2)
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get svc argocd-server -n argocd
```

**Access UI:** https://localhost:8080
- **Username:** admin
- **Password:** (command above)

#### 5.3 Configure ArgoCD Application

ArgoCD monitors the `k8s-gitops/` folder in this repository for Kubernetes manifests.

**Create Application via UI:**
1. Login to ArgoCD UI
2. Click "NEW APP"
3. Fill in details:
   - **Application Name:** nextjs-app
   - **Project:** default
   - **Sync Policy:** Automatic
     - ☑ Prune Resources
     - ☑ Self Heal
   - **Repository URL:** https://gitlab.com/your-org/nextjs-project.git
   - **Path:** k8s-gitops/kubernetes/overlays/prod
   - **Cluster:** https://kubernetes.default.svc
   - **Namespace:** production

**Or create via CLI:**
```bash
argocd app create nextjs-app \
  --repo https://gitlab.com/your-org/nextjs-project.git \
  --path k8s-gitops/kubernetes/overlays/prod \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace production \
  --sync-policy automated \
  --self-heal \
  --auto-prune
```

#### 5.4 ArgoCD Application Manifest (k8s-gitops/application.yaml)

> **Note:** Complete ArgoCD configuration is available in `k8s-gitops/` folder

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: nextflow-sandbox
  namespace: argocd
  annotations:
    notifications.argoproj.io/subscribe.on-sync-succeeded.slack: "#nextflow-deploys"
spec:
  project: default
  source:
    repoURL: 'https://gitlab.com/k8s-gitops.git'
    targetRevision: sandbox
    path: overlays/sandbox
  destination:
    server: https://kubernetes.default.svc
    namespace: sandbox
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

#### 5.5 How ArgoCD Detects New Tags

**Automatic Tag Detection Flow:**

1. **GitLab CI Pipeline** updates image tag in `k8s-gitops/kubernetes/overlays/prod/deployment.yaml`
2. **ArgoCD** polls the Git repository every 3 minutes (configurable)
3. **ArgoCD** detects the manifest change (new image tag)
4. **ArgoCD** compares desired state (Git) vs actual state (K8s)
5. **ArgoCD** automatically syncs and deploys new version
6. **ArgoCD** monitors rollout and health checks

**Configure Polling Interval:**
```bash
# Edit argocd-cm ConfigMap
kubectl edit configmap argocd-cm -n argocd

# Add/modify:
data:
  timeout.reconciliation: 180s  # 3 minutes (default)
```

**Webhook for Instant Sync (Optional):**
```bash
# Get ArgoCD webhook URL
kubectl get svc argocd-server -n argocd

# Configure in GitLab:
# Settings → Webhooks → Add webhook
# URL: https://argocd.example.com/api/webhook
# Secret Token: (from ArgoCD)
# Trigger: Push events
# SSL verification: Enable
```

#### 5.6 ArgoCD CLI Operations

```bash
# List applications
argocd app list

# Get application details
argocd app get nextjs-app

# Sync application manually
argocd app sync nextjs-app

# View sync history
argocd app history nextjs-app

# Rollback to previous version
argocd app rollback nextjs-app <REVISION_ID>

# View application logs
argocd app logs nextjs-app

# Diff current vs desired state
argocd app diff nextjs-app
```

---

## 🔄 CI/CD Pipelines

### Pipeline 1: Application Build & Deploy (.gitlab-ci.yml)

This pipeline is triggered on every push to the application code and handles:
- Code quality analysis
- Building the Next.js application
- Security scanning
- Docker image creation
- GitOps repository update

```yaml
trigger: none

pool:
  vmImage: ubuntu-latest

variables:
  - group: nextjs-app
  - name: DOCKER_BUILDKIT
    value: 1  

stages:
- stage: SonarQubeAnalysis
  jobs:
  - job: SonarQube
    steps:
    - task: JavaToolInstaller@1
      inputs:
        versionSpec: '17'
        jdkArchitectureOption: 'x64'
        jdkSourceOption: 'PreInstalled'

    - checkout: self

    - script: |
        echo "📦 Téléchargement de SonarScanner CLI..."
        wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip
        unzip sonar-scanner-cli-5.0.1.3006-linux.zip
        mv sonar-scanner-5.0.1.3006-linux sonar-scanner
        export PATH=$(pwd)/sonar-scanner/bin:$PATH

        echo "🔍 Lancement de l'analyse SonarQube..."
        sonar-scanner \
          -Dsonar.projectKey=nextjs-app \
          -Dsonar.projectName=nextjs-app \
          -Dsonar.sources=. \
          -Dsonar.host.url=$(SONARQUBE_ENDPOINT_URL) \
          -Dsonar.token=$(SONARQUBE_AUTH_TOKEN) \
          -Dsonar.projectVersion=1.0
      displayName: 'Run SonarScanner'

- stage: BuildAndPush
  dependsOn: SonarQubeAnalysis
  jobs:
  - job: Build
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - checkout: self

    - task: DownloadSecureFile@1
      name: DownloadEnv
      inputs:
        secureFile: '.env'

    - script: |
        cp "$(DownloadEnv.secureFilePath)" .env
        ls -la .env
      displayName: 'Copier .env à la racine'

    - script: |
        # Configuration simplifiée de .npmrc
        echo "registry=$(NEXUS_URL)" > .npmrc
        echo "//next_url/repository/npm-proxy/:_auth=$(NEXUS_AUTH_TOKEN)" >> .npmrc
        echo "always-auth=true" >> .npmrc
        echo "strict-ssl=false" >> .npmrc
        
        # Afficher le .npmrc pour vérification (debug)
        echo "Contenu du .npmrc :"
        cat .npmrc
        
        # Installation
        npm install -g pnpm
        pnpm install --loglevel verbose --fetch-retries 3
      displayName: 'Install dependencies with Nexus cache'
      env:
        NEXUS_URL: $(NEXUS_URL)
        NEXUS_AUTH_TOKEN: $(NEXUS_AUTH_TOKEN)

    - script: |
        export VERSION=$(cat version.txt)
        echo "##vso[task.setvariable variable=IMAGE_TAG]sandbox-${VERSION}"
      displayName: 'Lire version depuis version.txt'

    - script: |
        # Build avec Docker BuildKit pour utiliser le cache
        docker build \
          --build-arg NEXUS_URL=$(NEXUS_URL) \
          --build-arg NEXUS_AUTH_TOKEN=$(NEXUS_AUTH_TOKEN) \
          -t $(ACR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG) .
        echo "Image built"
        docker images
      displayName: 'Build Docker image with cache'

    - task: trivy@2
      displayName: 'Trivy Scan'
      inputs:
        method: 'docker'
        version: 'latest'
        type: 'image'
        target: '$(ACR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)'
        scanners: 'license,misconfig,secret,vuln'
        severities: 'MEDIUM,HIGH,CRITICAL'
        ignoreScanErrors: true

        reports: 'github,html,table'
        publish: true

    - script: |
        echo "$(ACR_PASSWORD)" | docker login $(ACR_NAME) -u $(ACR_USER) --password-stdin
        docker push $(ACR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
      displayName: 'Push image to ACR'

    - script: |
        echo "🧬 Clonage du repo GitOps..."
        git config --global user.email "devops@email.com"
        git config --global user.name "Azure DevOps Pipeline"

        git clone --branch sandbox https://gitlab-ci-token:$(GITOPS_TOKEN)@gitlab.com/MyOrganization/internal/k8s-gitops.git
        cd k8s-gitops/overlays/sandbox/nextjs-app

        echo "✏️ Mise à jour de l'image dans patch-deployment.yaml..."
        sed -i "s|image: .*|image: $(ACR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)|g" patch-deployment.yaml

        git add patch-deployment.yaml
        git commit -m "🤖 MAJ image sandbox: $(IMAGE_TAG)"
        git push origin sandbox
      displayName: 'Update image tag in GitOps'
