# Daily Guilty Law

面白い判例を通じて法律を学べる Flutter アプリ

## 🎯 プロジェクト概要

「Daily Guilty Law」は、AI Agent を活用して法律に興味のある一般ユーザー向けに、実在する面白い判例を毎日配信し、法律学習を身近で楽しいものにするモバイルアプリです。

### 主要機能

1. **今日のギルティー判例（Home）**

   - 実在する意外性の高い判例を毎日 1 件配信
   - スワイプ対応の TikTok 風 UI
   - "ひとことで言えば..."形式の親しみやすい解説

2. **時事コラボ（Compare）**

   - ニュースと類似する過去判例を比較表示
   - 社会ネタとのつながりを可視化

3. **ケース投稿ガチャ（Post）**
   - ユーザーの質問を AI が分析
   - リスクスコア付きで回答
   - 占い感覚の Q&A 体験

## 🏆 Google Cloud Japan AI Hackathon Vol.2 対応

- **AI サービス**: Vertex AI (Gemini 1.5 Flash + text-embedding-gecko)
- **アプリケーションサービス**: Cloud Run, Firestore, Cloud Storage
- **特別賞対応**: Flutter + Firebase 活用

## 🚀 技術スタック

### Frontend

- **Framework**: Flutter 3.x
- **State Management**: Riverpod 3
- **UI Components**: Material Design 3, Card Swiper
- **Navigation**: GoRouter

### Backend / AI

- **AI Platform**: Vertex AI Agent Engine
- **LLM**: Gemini 1.5 Flash
- **Embedding**: text-embedding-gecko-multilingual
- **Agent Framework**: LangGraph (Python)

### Infrastructure

- **Cloud**: Google Cloud Platform
- **Compute**: Cloud Run
- **Database**: Cloud Firestore
- **Storage**: Cloud Storage
- **Auth**: Firebase Authentication

## 📋 セットアップ手順

### 1. 前提条件

```bash
# Flutter SDKのインストール (3.8.0以上)
flutter --version

# Google Cloud CLI
gcloud --version
```

### 2. 環境設定

```bash
# リポジトリのクローン
git clone <repository-url>
cd daily-guilty-law

# 環境変数ファイルの作成
cp env.template .env
# .envファイルを編集して各種APIキーを設定

# 依存関係のインストール
flutter pub get

# コード生成
flutter packages pub run build_runner build
```

### 3. Google Cloud 設定

```bash
# プロジェクトの設定
gcloud config set project YOUR_PROJECT_ID

# Vertex AI APIの有効化
gcloud services enable aiplatform.googleapis.com

# 認証設定
gcloud auth application-default login
```

### 4. 実行

```bash
# 開発モード
flutter run

# リリースビルド
flutter build apk
flutter build ios
```

## 📁 プロジェクト構造

```
lib/
├── config/
│   └── app_config.dart          # アプリ設定
├── models/
│   ├── daily_case.dart          # データモデル
│   └── ai_response.dart         # AI応答モデル
├── providers/
│   └── legal_providers.dart     # Riverpod プロバイダー
├── screens/
│   ├── daily_case_screen.dart   # メイン画面
│   └── qa_screen.dart           # Q&A画面
├── services/
│   ├── legal_api_service.dart   # API クライアント
│   └── vertex_ai_service.dart   # Vertex AI サービス
└── main.dart                    # エントリーポイント
```

## 💰 コスト概算

### ハッカソン期間（17 日）

- **Vertex AI**: ~$1.5 (Gemini Flash + Embedding)
- **Cloud Run**: ~$0.8 (API 実行環境)
- **Firestore**: ~$0.02 (ユーザーデータ)
- **その他**: ~$0.5 (ストレージ、ログ等)
- **合計**: ~$3 USD (300 USD クレジット内)

### 本格運用時（1,000 DAU）

- **月額**: ~$40 USD

## 🔒 ガバナンス

### 法的対応

- **非弁行為回避**: 全回答に「一般情報」注意書き付与
- **PII 保護**: Cloud KMS による暗号化
- **引用必須**: 条文・判例の出典明記

### AI 倫理

- **Citation Filter**: Vertex AI 標準機能で未引用文をブロック
- **Content Filter**: 不適切コンテンツの自動検出
- **Human Review**: 重要コンテンツの人間レビュー

## 🎮 デモ・テスト

```bash
# ユニットテスト
flutter test

# インテグレーションテスト
flutter drive --target=test_driver/app.dart
```

## 📈 ロードマップ

- **Phase 1**: MVP リリース（ハッカソン）
- **Phase 2**: ユーザーフィードバック反映
- **Phase 3**: マルチエージェント機能拡張
- **Phase 4**: サブスクリプション導入

## 🤝 コントリビューション

1. フォークして機能ブランチを作成
2. 変更をコミット
3. プルリクエストを作成

## 📄 ライセンス

MIT License

## 📞 お問い合わせ

プロジェクトに関する質問やフィードバックは、GitHub の Issues までお願いします。
