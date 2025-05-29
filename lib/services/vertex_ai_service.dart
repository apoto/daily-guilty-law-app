import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/ai_response.dart';

class VertexAIService {
  static const String _baseUrl = 'https://asia-northeast1-aiplatform.googleapis.com';
  
  // 開発用のアクセストークン（本番では適切な認証を実装）
  String? _accessToken;
  
  String get projectId => dotenv.env['GOOGLE_CLOUD_PROJECT_ID'] ?? 'daily-guilty-law';
  String get location => dotenv.env['VERTEX_AI_LOCATION'] ?? 'asia-northeast1';
  String get model => dotenv.env['VERTEX_AI_MODEL'] ?? 'gemini-1.5-pro';

  /// 法律相談AI - ユーザーの質問に回答
  Future<AIResponse> askLegalQuestion(String question) async {
    try {
      final prompt = '''
あなたは日本の法律に精通した親しみやすい法律アドバイザーです。
一般の方にもわかりやすく、正確で実用的な法律情報を提供してください。

ユーザーの質問: $question

以下の形式で回答してください：
1. 簡潔な結論
2. 法的根拠（該当する法律・条文）
3. 具体例があれば紹介
4. 注意点や補足事項
5. より詳しく知りたい場合の推奨行動

※免責事項：この回答は一般的な情報提供であり、個別の法的アドバイスではありません。
具体的なケースについては弁護士にご相談ください。
''';

      return await _generateContent(prompt);
    } catch (e) {
      return AIResponse.error('法律相談の処理中にエラーが発生しました: $e');
    }
  }

  /// 判例クイズ生成 - 面白い判例を基にしたクイズを作成
  Future<QuizQuestion> generateQuizQuestion({String? category}) async {
    try {
      final prompt = '''
日本の面白い・珍しい判例を基にしたクイズを1問作成してください。
${category != null ? 'カテゴリ: $category' : ''}

以下のJSON形式で回答してください：
{
  "id": "unique_id",
  "question": "クイズの問題文",
  "options": ["選択肢1", "選択肢2", "選択肢3", "選択肢4"],
  "correctAnswer": 0,
  "explanation": "詳しい解説（判例の背景、法的ポイント、なぜ面白いのか）",
  "category": "分野（民法、刑法、商法など）",
  "difficulty": "初級|中級|上級"
}

要件：
- 実際の判例に基づく
- 興味深い事実関係
- 法的に勉強になる
- 4択で明確に正解が判断できる
- 解説は初心者にもわかりやすく
''';

      final response = await _generateContent(prompt);
      if (response.hasError) {
        throw Exception(response.error);
      }

      // JSONパースを試行
      try {
        final jsonData = json.decode(response.content);
        return QuizQuestion.fromJson(jsonData);
      } catch (e) {
        // JSONパースに失敗した場合、デフォルトクイズを返す
        return _getDefaultQuizQuestion();
      }
    } catch (e) {
      // エラー時はデフォルトクイズを返す
      return _getDefaultQuizQuestion();
    }
  }

  /// 今日の判例解説を取得
  Future<AIResponse> getTodaysCaseAnalysis() async {
    try {
      final prompt = '''
今日紹介する面白い日本の判例を1つ選んで、以下の形式で解説してください：

## 📖 今日の面白判例

**事件名**: [事件名]
**裁判所**: [裁判所名]
**年代**: [判決年]

### 🎭 事件の概要
[わかりやすく事実関係を説明]

### ⚖️ 争点
[何が法的に問題となったか]

### 📋 判決内容
[裁判所の判断]

### 💡 なぜ面白いのか
[この判例の興味深いポイント]

### 📚 学べること
[この判例から学べる法的知識]

要件：
- 実在する判例
- 一般の人が興味を持ちそうな事案
- 法的に学習価値がある
- わかりやすい文章
- 専門用語は説明を付ける
''';

      return await _generateContent(prompt);
    } catch (e) {
      return AIResponse.error('今日の判例取得中にエラーが発生しました: $e');
    }
  }

  /// 共通のコンテンツ生成メソッド
  Future<AIResponse> _generateContent(String prompt) async {
    try {
      // 開発段階ではモックレスポンスを返す
      if (dotenv.env['DEBUG_MODE'] == 'true') {
        return _getMockResponse(prompt);
      }

      // 実際のVertex AI APIコール（認証が必要）
      final url = '$_baseUrl/v1/projects/$projectId/locations/$location/publishers/google/models/$model:generateContent';
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'contents': [{
            'parts': [{'text': prompt}]
          }],
          'generationConfig': {
            'temperature': 0.7,
            'topP': 0.8,
            'topK': 40,
            'maxOutputTokens': 2048,
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final content = data['candidates'][0]['content']['parts'][0]['text'];
        return AIResponse(content: content);
      } else {
        return AIResponse.error('API呼び出しエラー: ${response.statusCode}');
      }
    } catch (e) {
      return AIResponse.error('通信エラー: $e');
    }
  }

  /// 開発用モックレスポンス
  AIResponse _getMockResponse(String prompt) {
    if (prompt.contains('法律相談')) {
      return const AIResponse(
        content: '''## 📋 法的見解

**結論**: ご質問の件について、以下のように考えられます。

**法的根拠**: 
- 民法第○○条
- ○○法第○○条

**具体例**: 
類似のケースでは...

**注意点**: 
個別の事情により判断が変わる可能性があります。

**推奨行動**: 
詳細については弁護士にご相談されることをお勧めします。

※この回答は一般的な情報提供であり、個別の法的アドバイスではありません。''',
        confidence: 0.85,
      );
    }

    if (prompt.contains('今日の判例')) {
      return const AIResponse(
        content: '''## 📖 今日の面白判例

**事件名**: ペット火葬業者と飼い主の契約紛争事件
**裁判所**: 東京地方裁判所
**年代**: 2018年

### 🎭 事件の概要
ペットの火葬を依頼した飼い主が、返骨されたお骨が自分のペットではないのではないかと疑い、DNA鑑定を求めて訴訟を起こした事件。

### ⚖️ 争点
- 火葬業者の説明義務の範囲
- ペットの死体の取り違えの立証責任
- 慰謝料の算定方法

### 📋 判決内容
裁判所は火葬業者の説明不足を認定し、一部の慰謝料支払いを命じました。

### 💡 なぜ面白いのか
ペットの法的地位や、物として扱われる中での感情的価値をどう評価するかという現代的な問題を扱っている点。

### 📚 学べること
契約における説明義務の重要性と、新しい社会問題に対する法的対応について学べます。''',
        confidence: 0.90,
      );
    }

    return const AIResponse(
      content: 'モック応答: AIサービスが正常に動作しています。',
      confidence: 0.95,
    );
  }

  /// デフォルトクイズ問題
  QuizQuestion _getDefaultQuizQuestion() {
    return QuizQuestion(
      id: 'default_001',
      question: '日本で「ポケモン商標権侵害事件」として有名になった判例で、任天堂が勝訴した理由は？',
      options: [
        '商標権の先願主義により任天堂が先に商標登録していたため',
        'ポケモンのキャラクターデザインが著作権で保護されていたため', 
        '不正競争防止法違反が認められたため',
        'すべて正しい'
      ],
      correctAnswer: 3,
      explanation: '''この事件では複数の法的保護が働きました：
1. 商標権：「ポケットモンスター」の商標権
2. 著作権：キャラクターデザインの著作権  
3. 不正競争防止法：周知表示混同惹起行為

知的財産権は重層的に保護されており、一つの商品に複数の権利が適用されることがよくあります。''',
      category: '知的財産法',
      difficulty: '中級',
    );
  }

  /// アクセストークンを設定（開発用）
  void setAccessToken(String token) {
    _accessToken = token;
  }
} 