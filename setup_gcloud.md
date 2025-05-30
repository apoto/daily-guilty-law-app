# Google Cloud Setup for Daily Guilty Law

## 1. Google Cloud Project Setup

### 必要な API の有効化

```bash
# Vertex AI API
gcloud services enable aiplatform.googleapis.com

# Cloud Run API (デプロイ用)
gcloud services enable run.googleapis.com

# Firestore API
gcloud services enable firestore.googleapis.com

# Firebase Authentication API
gcloud services enable firebase.googleapis.com

# Cloud Storage API
gcloud services enable storage.googleapis.com
```

### 2. Vertex AI Agent Builder 設定

1. Google Cloud Console で「Vertex AI」→「Agent Builder」に移動
2. 新しいアプリを作成:
   - App type: Chat
   - Name: daily-guilty-law-agent
   - Region: asia-northeast1 (東京)

### 3. データストアの作成

```bash
# 判例データ用のデータストア
curl -X POST \
  "https://discoveryengine.googleapis.com/v1/projects/YOUR_PROJECT_ID/locations/asia-northeast1/collections/default_collection/dataStores" \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -d '{
    "displayName": "legal-cases-datastore",
    "industryVertical": "GENERIC",
    "solutionTypes": ["SOLUTION_TYPE_CHAT"],
    "contentConfig": "CONTENT_REQUIRED"
  }'
```

### 4. サービスアカウントの作成

```bash
# サービスアカウント作成
gcloud iam service-accounts create daily-guilty-law-sa \
    --description="Service account for Daily Guilty Law app" \
    --display-name="Daily Guilty Law Service Account"

# 必要な権限を付与
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
    --member="serviceAccount:daily-guilty-law-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/aiplatform.user"

gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
    --member="serviceAccount:daily-guilty-law-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/discoveryengine.editor"

# キーファイルの生成
gcloud iam service-accounts keys create credentials.json \
    --iam-account=daily-guilty-law-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com
```

### 5. 環境変数の設定

`.env`ファイルを作成:

```env
GOOGLE_CLOUD_PROJECT_ID=your-project-id
GOOGLE_CLOUD_REGION=asia-northeast1
VERTEX_AI_ENDPOINT=https://asia-northeast1-aiplatform.googleapis.com
AGENT_ENGINE_ID=your-agent-engine-id
AGENT_ENGINE_LOCATION=asia-northeast1
ENVIRONMENT=development
SENTRY_DSN=your-sentry-dsn-here
```

### 6. Firebase 設定

1. Firebase Console で新しいプロジェクトを作成（または既存の Google Cloud プロジェクトを使用）
2. Authentication → Sign-in method で Email/Password を有効化
3. Firestore Database を作成（asia-northeast1 リージョン）
4. Flutter 用の設定ファイルをダウンロード:
   - `google-services.json` (Android 用)
   - `GoogleService-Info.plist` (iOS 用)

### 7. コスト最適化設定

```bash
# 予算アラートの設定
gcloud billing budgets create \
    --billing-account=YOUR_BILLING_ACCOUNT_ID \
    --display-name="Daily Guilty Law Budget" \
    --budget-amount=50USD \
    --threshold-rule=percent=80,basis=CURRENT_SPEND \
    --threshold-rule=percent=100,basis=CURRENT_SPEND
```
