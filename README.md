# ☁️ AuraFinOps // Autonomous Cloud Cost Optimization & FinOps Engine

![FinOps](https://img.shields.io/badge/FinOps-Enterprise-00F0FF?style=for-the-badge)
![AWS](https://img.shields.io/badge/AWS-Cloud_Cost_Optimization-FF9900?style=for-the-badge&logo=amazonaws)
![Terraform](https://img.shields.io/badge/Terraform-Infrastructure_as_Code-844FBA?style=for-the-badge&logo=terraform)
![Python](https://img.shields.io/badge/Python-Automated_Scaling_Efficiency-3776AB?style=for-the-badge&logo=python)

An enterprise-grade, multi-region **Cloud Financial Operations (FinOps)** platform. AuraFinOps programmatically detects infrastructure waste, automates data governance, and executes zero-downtime programmatic instance downscaling (Right-Sizing) to maximize institutional cloud ROI and AWS/GCP Resource Allocation.

## 🚀 Live Interactive Command Center
View the operational executive FinOps dashboard here:
👉 **[https://aakashpandian582006-ops.github.io/AuraFinOps/aurafinops-dashboard/](https://aakashpandian582006-ops.github.io/AuraFinOps/aurafinops-dashboard/)**

---

## 💡 Core Features & ATS Keywords
This project demonstrates senior-level proficiency in modern cloud computing architecture:
- **Cloud Cost Optimization:** Eliminates idle compute waste by automatically detecting underutilized instances.
- **Automated Scaling Efficiency:** Hot-swaps EC2 instance types via the Boto3 SDK with zero downtime.
- **Anomalous Spend Detection:** Evaluates 7-day CloudWatch telemetry metrics to flag infrastructure bleed.
- **Infrastructure as Code (IaC):** Utilizes Terraform to programmatically deploy and govern multi-region environments.
- **Data Governance & Compliance:** Centralized S3 Data Lakes configured with strict AES-256 encryption.

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
* **Visibility:** Translates raw backend telemetry data streams into a sleek multi-region status grid, real-time anomalous spend logs, and an annualized corporate financial savings tracker.

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
```

### 2. Execute FinOps Engine
```bash
cd aurafinops-core
python3 cost_optimizer.py --region us-east-1
```