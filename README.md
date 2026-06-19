# AuraFinOps // Autonomous Multi-Region Cloud Cost Optimization Engine

An enterprise-grade, multi-region cloud financial operations (FinOps) platform. AuraFinOps programmatically detects infrastructure waste, automates data governance, and executes programmatic instance downscaling to maximize institutional cloud ROI.

## 🚀 Live Interactive Command Center
View the operational executive dashboard here:
👉 **[https://aakashpandian582006-ops.github.io/AuraFinOps/aurafinops-dashboard/](https://aakashpandian582006-ops.github.io/AuraFinOps/aurafinops-dashboard/)**

---

## 🏗️ Architectural Core Infrastructure

The platform is designed across three highly decoupled, enterprise layers:

### 1. Infrastructure Layer (`aurafinops-infra`)
* **Technology:** Terraform (Infrastructure as Code)
* **Design:** Declares secure multi-region topologies (`us-east-1` and `us-west-2`).
* **Governance:** Deploys a centralized AWS S3 Data Lake configured with default AES-256 server-side encryption rules and explicit Public Access Blocks to protect sensitive financial logs.

### 2. Automation Engine (`aurafinops-core`)
* **Technology:** Python & AWS Boto3 SDK
* **Logic:** Programmatically processes CloudWatch log metric streams. If compute nodes (EC2) fall below a strict **5% CPU utilization threshold over a 7-day testing window**, the engine isolates the target ID, archives the telemetry payload into the S3 data lake as JSON, and invokes downscaling APIs to hot-swap instances to a cost-effective `t3.micro` tier.

### 3. Executive Visibility Layer (`aurafinops-dashboard`)
* **Technology:** Semantic HTML5, Custom CSS Variables, JavaScript Emitter Pipelines
* **Visibility:** Translates raw backend telemetry data streams into a sleek multi-region status grid, real-time logging output window, and an annualized corporate financial savings tracker.

---

## ⚙️ How to Deploy Locally

### Prerequisites
* Terraform v1.5.0+
* Python 3.10+ with `boto3` installed
* AWS CLI configured with appropriate IAM execution roles

### 1. Initialize Cloud Topology
```bash
cd aurafinops-infra
terraform init
terraform apply -auto-approve