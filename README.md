# Terraform AWS Infrastructure with S3 Backend & DynamoDB State Locking

## Project Purpose

---

The purpose of this project is to implement **Terraform remote state management using AWS S3 and DynamoDB** so that:

* Terraform state is stored centrally in **Amazon S3**
* State changes are protected from conflicts using **DynamoDB state locking**
* Multiple users can work on the same infrastructure **without overwriting each other’s changes**
* Real-world issues like **state lock errors, duplicate resources, and backend reconfiguration** are understood and resolved
* AWS infrastructure (**EC2, Security Group, Key Pair, VPC**) is managed using **Infrastructure as Code (IaC)** following production best practices

**In short:**
This project simulates how Terraform is used by real DevOps teams with a **remote backend and state locking on AWS**.

---

## Project Overview

---

This project demonstrates a **production-grade Terraform setup** implementing:

* **Amazon S3** as a remote backend for Terraform state storage
* **Amazon DynamoDB** for state locking and consistency control
* **AWS EC2 infrastructure** provisioning along with security groups and key pairs

This is a **real-world DevOps implementation** that shows how enterprise teams manage Terraform state safely across **multiple engineers** without conflicts or state corruption.

---

## Problem Statement

In collaborative DevOps environments, multiple engineers often work on the same infrastructure code. Without proper state management:

* Concurrent `terraform apply` runs can **corrupt the state file**
* Infrastructure changes become **unpredictable and inconsistent**
* Team collaboration becomes **difficult and error-prone**

### Solution

This project implements **distributed state locking** using DynamoDB, ensuring:

* Only one user can modify infrastructure at a time
* State file integrity is maintained
* Automatic lock acquisition and release
* Safe collaborative Terraform workflows

---

##  Architecture

```
┌─────────────┐
│   Dev Team  │
└──────┬──────┘
       │
       ├──────► Terraform CLI
       │
       ▼
┌──────────────────────────────────┐
│     AWS Cloud Infrastructure     │
│                                  │
│  ┌────────────┐  ┌────────────┐  │
│  │  S3 Bucket │  │  DynamoDB  │  │
│  │   (State)  │  │   (Lock)   │  │
│  └────────────┘  └────────────┘  │
│                                  │
│  ┌────────────────────────────┐  │
│  │  EC2 + Security Group +    │  │
│  │       Key Pair             │  │
│  └────────────────────────────┘  │
└──────────────────────────────────┘
```

---

## Project Structure

```
HW_Terra_Practice/
│
├── remote-infra/          # One-time infra
│   ├── s3.tf
│   ├── dynamodb.tf
│   ├── provider.tf
│   └── terraform.tf
│
├── terraform.tf           # Main infra backend config
├── ec2.tf                 # EC2 instance resource definition
├── variables.tf           # Parameterized input variables
├── outputs.tf             # Output values (IP, instance ID, etc.)
└── README.md
```

---

## Technologies Used

* **Terraform** - Infrastructure as Code
* **AWS EC2** - Compute instances
* **AWS S3** - Remote state storage
* **AWS DynamoDB** - State locking mechanism
* **AWS IAM** - Access management
* **Git** - Version control

---

## Backend Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-12345"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}
```

---

## Getting Started

### Clone the repository

```bash
git clone https://github.com/prathmeshpawar12/Terraform-AWS-Infrastructure-with-S3-Backend-DynamoDB-State-Locking.git
cd Terraform-AWS-Infrastructure-with-S3-Backend-DynamoDB-State-Locking
```

### Run Terraform

```bash
terraform init
terraform plan
terraform apply
```

---

### Key Learnings
* Remote State Storage - S3 for centralized state management.

* State Locking - DynamoDB prevents concurrent modifications.

* Version Control - .gitignore excludes sensitive files.

* Modular Code - Separate files for different resources.

* Documentation - Comprehensive README and inline comments.

* Error Handling - Common issues documented with solutions.



### Real-World Use Cases

This pattern is used in:

* Enterprise DevOps Teams - Multiple engineers collaborating.

* CI/CD Pipelines - Jenkins, GitLab CI, GitHub Actions.

* Multi-Environment Deployments - Dev, Staging, Production.

* Infrastructure Compliance - change tracking
---

## Author

**Prathmesh Pawar**

  * DevOps Engineer
  * AWS  Engineer
---




