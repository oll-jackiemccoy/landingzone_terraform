# Terraform Landing Zone

This guide walks you through creating your **Management/Payer Account (MPA)**, setting up an **AWS Organization**, and bootstrapping **remote Terraform state** with S3 + DynamoDB locking.
---

## Prerequisites

- A dedicated email address for the **Management (Payer) Account (MPA)**.  
- AWS CLI v2 configured (`aws configure`) and an IAM user/role in the MPA with permissions to manage Organizations, S3, and DynamoDB.  
- Terraform ≥ 1.5 installed.  

---

## 1. Create the Management (Payer) Account (MPA)

1. Go to [AWS](https://aws.amazon.com/) and **Create a new AWS account**.  
2. Complete billing setup (credit card, contact info).  
3. Sign in with the **root user** once, enable **MFA**, and then create an **admin IAM user/role** for daily work.
## 2. Set Up AWS Organizations

1. From the MPA, go to **AWS Organizations** → **Create organization** → **Enable all features**.  
