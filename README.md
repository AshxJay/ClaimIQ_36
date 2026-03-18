<div align="center">

# 🛡️ ClaimIQ
### Cloud-Based Insurance Claim Management System

![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white)

*A full-stack, cloud-native platform where policyholders submit claims and adjusters review them through a powerful admin dashboard — all powered by AWS.*

</div>

---

## 🌐 Live URLs

| 🖥️ Service | 🔗 URL |
|---|---|
| **Frontend** | http://claimiq-frontend-ash.s3-website.ap-south-1.amazonaws.com |
| **Backend API** | http://13.235.56.205:3000 |
| **Health Check** | http://13.235.56.205:3000/health |

> ⚠️ **Note:** The backend IP changes if the ECS task restarts. Run `get-backend-ip.cmd` to get the latest IP automatically.

---

## 🔐 Test Accounts

| 👤 Role | 📧 Email | 🔑 Password |
|---|---|---|
| **Policyholder** | test@example.com | Test@1234 |
| **Adjuster** | adjuster@example.com | Test@1234 |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│     React Frontend (AWS S3 Hosting)     │
└─────────────────┬───────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────┐
│      Amazon Cognito (Auth + JWT)        │
└─────────────────┬───────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────┐
│   Node.js / Express API (ECS Fargate)   │
│         🐳 Dockerized Container         │
└──────┬──────────┬───────────┬───────────┘
       │          │           │
       ▼          ▼           ▼
┌──────────┐ ┌────────┐ ┌──────────┐
│ DynamoDB │ │  S3    │ │ SES/SNS  │
│ (Claims) │ │ (Docs) │ │ (Emails) │
└──────────┘ └────────┘ └──────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│     CloudWatch (Logs + Monitoring)      │
└─────────────────────────────────────────┘
```

---

## ✨ Features

### 👤 Policyholder Portal
- 🔐 Secure login via Amazon Cognito
- 📝 Submit insurance claims (auto, home, health, life, travel)
- 📁 Upload supporting documents directly to S3
- 📊 Track claim status in real time
- 📧 Receive email notifications on status changes

### 🧑‍💼 Adjuster Dashboard
- 📋 View and manage all submitted claims
- 🔍 Filter and search claim queue
- 📄 Review claim details and documents
- ✅ Approve, reject, or request more information
- 🗒️ Add internal adjuster notes
- 🚨 Fraud risk scoring per claim

---

## 🛠️ Tech Stack

### 🎨 Frontend
| Technology | Purpose |
|---|---|
| React 19 + TypeScript | UI framework |
| Vite | Build tool |
| Tailwind CSS | Styling |
| TanStack Query | Data fetching & caching |
| Zustand | State management |
| AWS Amplify | Cognito authentication |
| Axios | HTTP client |
| Framer Motion | Animations |
| Recharts | Charts & analytics |

### ⚙️ Backend
| Technology | Purpose |
|---|---|
| Node.js + Express | REST API server |
| AWS SDK v3 | AWS service integration |
| aws-jwt-verify | Cognito JWT validation |
| Docker | Containerization |

### ☁️ AWS Services
| Service | Purpose |
|---|---|
| 🔐 Amazon Cognito | User auth, JWT tokens, role management |
| 🚀 Amazon ECS Fargate | Serverless container hosting |
| 📦 Amazon ECR | Docker image registry |
| 🗄️ Amazon DynamoDB | NoSQL database for claims |
| 🪣 Amazon S3 | Document storage + frontend hosting |
| 📧 Amazon SES | Email notifications |
| 📊 Amazon CloudWatch | Logs and monitoring |
| 🌐 Amazon VPC | Network security |

---

## 📁 Project Structure

```
ClaimIQ/
├── 📂 backend/                   # Node.js Express API
│   ├── 📂 src/
│   │   ├── 📂 middleware/
│   │   │   ├── auth.js           # Cognito JWT verification
│   │   │   └── roleCheck.js      # Role-based access control
│   │   ├── 📂 routes/
│   │   │   ├── claims.js         # Claims CRUD endpoints
│   │   │   └── documents.js      # S3 pre-signed URL endpoints
│   │   ├── 📂 services/
│   │   │   ├── dynamodb.js       # DynamoDB operations
│   │   │   ├── s3.js             # S3 pre-signed URLs
│   │   │   └── ses.js            # Email notifications
│   │   └── index.js              # Express app entry point
│   ├── .env.example
│   ├── Dockerfile
│   └── package.json
├── 📂 src/                       # React frontend
│   ├── 📂 components/            # Reusable UI components
│   ├── 📂 hooks/                 # React Query hooks
│   ├── 📂 lib/                   # API client, auth, utilities
│   ├── 📂 pages/
│   │   ├── 📂 auth/              # Login, MFA
│   │   ├── 📂 policyholder/      # Claim submission, list
│   │   └── 📂 adjuster/          # Dashboard, queue, review
│   ├── 📂 store/                 # Zustand state
│   └── 📂 types/                 # TypeScript types
├── 🪟 get-backend-ip.cmd         # Script to get current ECS IP
└── 📋 task-definition.json       # ECS task definition
```

---

## 🔌 REST API Endpoints

| Method | Endpoint | Role | Description |
|---|---|---|---|
| `GET` | `/health` | 🌐 Public | Health check |
| `POST` | `/claims` | 👤 Policyholder | Submit new claim |
| `GET` | `/claims` | 👥 Both | List claims (scoped by role) |
| `GET` | `/claims/:id` | 👥 Both | Get claim detail |
| `PATCH` | `/claims/:id/status` | 🧑‍💼 Adjuster | Update claim status |
| `POST` | `/claims/:id/upload-url` | 👤 Policyholder | Get S3 pre-signed upload URL |
| `GET` | `/claims/:id/download-url` | 👥 Both | Get S3 pre-signed download URL |

---

## 🗄️ DynamoDB Schema

**Table:** `Claims` | **Partition Key:** `claimId` | **GSI:** `userId-index`

| Field | Type | Description |
|---|---|---|
| `claimId` | String | UUID — partition key |
| `userId` | String | Cognito sub — GSI key |
| `status` | String | submitted / under_review / approved / rejected |
| `claimType` | String | auto / home / health / life / travel |
| `description` | String | Claim description |
| `documentKeys` | List | S3 object keys |
| `adjusterNotes` | String | Internal adjuster notes |
| `createdAt` | String | ISO timestamp |
| `updatedAt` | String | ISO timestamp |

---

## 🚀 Local Development

### Prerequisites
- Node.js 20+
- AWS CLI configured (`aws configure`)
- Docker Desktop

### ⚙️ Backend Setup

```bash
cd backend
cp .env.example .env
# Fill in your AWS values in .env
npm install
npm run dev
```

### 🎨 Frontend Setup

```bash
npm install
# Create .env.local with your values
npm run dev
```

### 🔑 Environment Variables

**Backend** (`backend/.env`):
```env
PORT=3000
AWS_REGION=ap-south-1
COGNITO_USER_POOL_ID=your_pool_id
COGNITO_CLIENT_ID=your_client_id
DYNAMODB_TABLE_NAME=Claims
S3_BUCKET_NAME=your_bucket_name
SES_SENDER_EMAIL=your_verified_email
```

**Frontend** (`.env.local`):
```env
VITE_API_BASE_URL=http://localhost:3000
VITE_MOCK=false
VITE_COGNITO_USER_POOL_ID=your_pool_id
VITE_COGNITO_CLIENT_ID=your_client_id
VITE_AWS_REGION=ap-south-1
```

---

## 📦 Deployment

### 🐳 Backend — ECS Fargate

```bash
# Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 927046305762.dkr.ecr.ap-south-1.amazonaws.com

# Build & push image
docker build -t claimiq-backend ./backend
docker tag claimiq-backend:latest 927046305762.dkr.ecr.ap-south-1.amazonaws.com/claimiq-backend:latest
docker push 927046305762.dkr.ecr.ap-south-1.amazonaws.com/claimiq-backend:latest

# Deploy
aws ecs update-service --cluster claimiq-cluster --service claimiq-backend-service --force-new-deployment --region ap-south-1
```

### 🌐 Frontend — S3

```bash
npm run build
aws s3 sync dist/ s3://claimiq-frontend-ash --region ap-south-1
```

### 🔍 Get Current Backend IP

```bash
# Run this whenever the ECS task restarts
get-backend-ip.cmd
```

---

## 💰 Cost Management

> Stop ECS when not in use to avoid charges (~$0.01/hour)

```bash
# ⏹️ Stop
aws ecs update-service --cluster claimiq-cluster --service claimiq-backend-service --desired-count 0 --region ap-south-1

# ▶️ Start
aws ecs update-service --cluster claimiq-cluster --service claimiq-backend-service --desired-count 1 --region ap-south-1
```

---

## ☁️ AWS Infrastructure

| Resource | Name |
|---|---|
| 🚀 ECS Cluster | claimiq-cluster |
| ⚙️ ECS Service | claimiq-backend-service |
| 📦 ECR Repository | claimiq-backend |
| 🗄️ DynamoDB Table | Claims |
| 🪣 S3 (Documents) | claimiq-documents-ash |
| 🌐 S3 (Frontend) | claimiq-frontend-ash |
| 🔐 Cognito User Pool | ap-south-1_GDEQG1Dlb |
| 📊 CloudWatch Log Group | /ecs/claimiq-backend |
| 🌍 Region | ap-south-1 (Mumbai, India) |

---

## 📚 Academic Context

This project was built as **Problem 36** for a Cloud Computing + Full Stack assignment, demonstrating:

- ✅ Cloud-native application architecture
- ✅ Containerization with Docker
- ✅ Serverless container deployment (ECS Fargate)
- ✅ AWS managed services integration
- ✅ Role-based access control (Policyholder / Adjuster)
- ✅ Secure encrypted document storage
- ✅ Real-time email notifications
- ✅ Application monitoring and logging

---

<div align="center">

**Built with ❤️ on AWS — ap-south-1 (Mumbai)**

</div>
