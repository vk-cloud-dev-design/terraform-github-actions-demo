<div align="center">

# 🚀 Terraform Automation with GitHub Actions

[![Terraform](https://img.shields.io/badge/Terraform-v1.6+-844FBA?style=flat-square&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?style=flat-square&logo=github-actions&logoColor=white)](https://github.com/features/actions)
[![OpenID Connect](https://img.shields.io/badge/Auth-OIDC_Federated-green?style=flat-square&logo=openid)](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

An enterprise-grade, automated CI/CD pipeline built with **GitHub Actions** and **Terraform** to enforce automated linting, syntax validation, speculative execution plans on pull requests, and automated deployment on merge.

</div>

---

## 📐 Architecture & Workflow Pipeline

The diagram below outlines the dual-stage deployment lifecycle. Pull requests trigger non-destructive validation and planning, while pushes to `main` execute resource deployment.

<div align="center">

<svg width="100%" height="220" viewBox="0 0 900 220" xmlns="http://www.w3.org/2000/svg" style="max-width: 900px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;">
  <defs>
    <filter id="shadow" x="-5%" y="-5%" width="110%" height="115%" filterUnits="userSpaceOnUse">
      <feDropShadow dx="0" dy="3" stdDeviation="4" flood-opacity="0.12" />
    </filter>
    <marker id="arrow" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M 0 1.5 L 8 5 L 0 8.5 z" fill="#64748B" />
    </marker>
  </defs>

  <!-- Pull Request Pipeline Stage -->
  <rect x="20" y="30" width="410" height="160" rx="10" fill="#F8FAFC" stroke="#CBD5E1" stroke-width="1.5" />
  <text x="40" y="55" font-size="13" font-weight="700" fill="#334155" letter-spacing="0.5">PR STAGE: VALIDATE & PLAN</text>

  <!-- Node 1: PR -->
  <rect x="40" y="78" width="105" height="52" rx="6" fill="#FFFFFF" stroke="#0284C7" stroke-width="1.5" filter="url(#shadow)" />
  <text x="92" y="102" font-size="12" font-weight="600" fill="#0F172A" text-anchor="middle">PR Opened</text>
  <text x="92" y="118" font-size="10" fill="#64748B" text-anchor="middle">feature/ → main</text>

  <line x1="145" y1="104" x2="175" y2="104" stroke="#64748B" stroke-width="1.5" marker-end="url(#arrow)" />

  <!-- Node 2: Checks -->
  <rect x="180" y="78" width="110" height="52" rx="6" fill="#FFFFFF" stroke="#64748B" stroke-width="1.2" filter="url(#shadow)" />
  <text x="235" y="102" font-size="12" font-weight="600" fill="#0F172A" text-anchor="middle">Lint & Validate</text>
  <text x="235" y="118" font-size="10" fill="#64748B" text-anchor="middle">fmt / check / init</text>

  <line x1="290" y1="104" x2="315" y2="104" stroke="#64748B" stroke-width="1.5" marker-end="url(#arrow)" />

  <!-- Node 3: Plan -->
  <rect x="320" y="78" width="95" height="52" rx="6" fill="#FFFFFF" stroke="#0284C7" stroke-width="1.5" filter="url(#shadow)" />
  <text x="367" y="102" font-size="12" font-weight="600" fill="#0F172A" text-anchor="middle">TF Plan</text>
  <text x="367" y="118" font-size="10" fill="#0284C7" text-anchor="middle">Comment on PR</text>

  <!-- Flow Connector between PR and Merge -->
  <line x1="430" y1="110" x2="470" y2="110" stroke="#94A3B8" stroke-dasharray="4 4" stroke-width="1.5" marker-end="url(#arrow)" />

  <!-- Deployment Stage -->
  <rect x="475" y="30" width="405" height="160" rx="10" fill="#F8FAFC" stroke="#CBD5E1" stroke-width="1.5" />
  <text x="495" y="55" font-size="13" font-weight="700" fill="#166534" letter-spacing="0.5">DEPLOY STAGE: PROD APPLY</text>

  <!-- Node 4: Merge -->
  <rect x="495" y="78" width="105" height="52" rx="6" fill="#FFFFFF" stroke="#16A34A" stroke-width="1.5" filter="url(#shadow)" />
  <text x="547" y="102" font-size="12" font-weight="600" fill="#0F172A" text-anchor="middle">PR Merged</text>
  <text x="547" y="118" font-size="10" fill="#64748B" text-anchor="middle">Push to main</text>

  <line x1="600" y1="104" x2="630" y2="104" stroke="#64748B" stroke-width="1.5" marker-end="url(#arrow)" />

  <!-- Node 5: Apply -->
  <rect x="635" y="78" width="105" height="52" rx="6" fill="#FFFFFF" stroke="#16A34A" stroke-width="1.5" filter="url(#shadow)" />
  <text x="687" y="102" font-size="12" font-weight="600" fill="#0F172A" text-anchor="middle">TF Apply</text>
  <text x="687" y="118" font-size="10" fill="#16A34A" text-anchor="middle">Auto-approve</text>

  <line x1="740" y1="104" x2="765" y2="104" stroke="#64748B" stroke-width="1.5" marker-end="url(#arrow)" />

  <!-- Node 6: Cloud -->
  <rect x="770" y="78" width="95" height="52" rx="6" fill="#FFFFFF" stroke="#844FBA" stroke-width="1.5" filter="url(#shadow)" />
  <text x="817" y="102" font-size="12" font-weight="600" fill="#0F172A" text-anchor="middle">Live Cloud</text>
  <text x="817" y="118" font-size="10" fill="#844FBA" text-anchor="middle">State Locked</text>
</svg>

</div>

---

## ✨ Key Capabilities

* **Automated Speculative Runs:** PRs automatically generate a plan output directly injected into PR discussion threads.
* **Secretless Authentication (OIDC):** Uses OpenID Connect Federated tokens rather than static, long-lived access keys.
* **Concurrency Locking:** Cloud state backend integrates native locking to prevent conflicting parallel apply runs.
* **Deterministic Versioning:** Core dependencies, provider binaries, and GitHub Actions pins are locked to explicit versions.

---

## 📁 Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── terraform-plan.yml      # Triggered on pull_request to main
│       └── terraform-apply.yml     # Triggered on push (merge) to main
├── modules/                        # Encapsulated, reusable infrastructure components
├── backend.tf                      # Remote state backend declaration
├── main.tf                         # Root resources and orchestration
├── variables.tf                    # Parameter inputs and strict validations
├── outputs.tf                      # Resulting state outputs
└── versions.tf                     # Provider and Terraform version constraints
```

---

## ⚙️ Secrets & Authentication Setup

Store the following secrets under **Repository Settings > Secrets and variables > Actions**:

| Secret Name | Purpose | Example / Required Format |
| :--- | :--- | :--- |
| `ARM_CLIENT_ID` / `AWS_ROLE_ARN` | Workload identity client ID or role ARN | `00000000-0000-0000-0000-000000000000` |
| `ARM_TENANT_ID` | Identity directory tenant ID | `00000000-0000-0000-0000-000000000000` |
| `ARM_SUBSCRIPTION_ID` | Target cloud subscription ID | `00000000-0000-0000-0000-000000000000` |
| `BACKEND_STORAGE_ACCOUNT` | Name of remote state storage resource | `tfstatestorageaccount` |

---

## 🛠️ Local Development

Ensure the [Terraform CLI](https://developer.hashicorp.com/terraform/install) is installed locally before contributing:

```bash
# 1. Clone repository
git clone https://github.com/<your-org>/terraform-github-actions-demo.git
cd terraform-github-actions-demo

# 2. Format checks and syntax validation
terraform fmt -recursive
terraform init -backend=false
terraform validate

# 3. Dry-run execution against test variables
terraform plan -var-file=environments/dev.tfvars
```

---

## 🛡️ Best Practices & Guardrails

* **Branch Protection:** Keep the `main` branch protected. Require at least one approving review and successful execution of the `terraform-plan` workflow before merges.
* **Never Commit State:** Verify that `*.tfstate`, `*.tfstate.backup`, `.terraform/`, and local credentials are listed inside `.gitignore`.
* **Least-Privilege RBAC:** The deployment role/service principal must only possess write access to resources specified within the scoped configurations.
