import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import '../models/daily_case.dart';
import '../config/app_config.dart';
import '../models/news_comparison.dart';
import '../models/gacha_result.dart';
import '../models/quiz_question.dart';
import '../models/study_card.dart';

class VertexAIService {
  static const bool _isVertexAIEnabled = true; // Vertex AI APIを有効化

  late final GenerativeModel _model;

  VertexAIService() {
    if (_isVertexAIEnabled) {
      _model = FirebaseVertexAI.instance.generativeModel(
        model: 'gemini-1.5-flash',
        safetySettings: [
          SafetySetting(
            HarmCategory.harassment,
            HarmBlockThreshold.medium,
            null,
          ),
          SafetySetting(
            HarmCategory.hateSpeech,
            HarmBlockThreshold.medium,
            null,
          ),
          SafetySetting(
            HarmCategory.sexuallyExplicit,
            HarmBlockThreshold.medium,
            null,
          ),
          SafetySetting(
            HarmCategory.dangerousContent,
            HarmBlockThreshold.medium,
            null,
          ),
        ],
      );
    }
  }

  /// Daily Case生成
  Future<DailyCase> generateDailyCase() async {
    // Vertex AI APIが無効の場合はモックデータを返す
    if (!_isVertexAIEnabled) {
      debugPrint('Vertex AI API無効: モックデータを使用');
      return _getMockDailyCase();
    }

    try {
      final prompt = '''
あなたは法律教育の専門家です。一般の人が興味を持ちやすい実際の判例を基に、Daily Guilty Lawアプリ用のコンテンツを作成してください。

要件:
1. 実際の判例を基にした内容
2. 一般の人が理解しやすい表現
3. 興味深く、話題性のある事例
4. 法的な正確性を保持

以下のJSON形式で回答してください:
{
  "title": "判例のタイトル",
  "question": "事案の概要（問題提起）",
  "answerShort": "結論（一言で表現）",
  "answerLong": "詳細な解説",
  "interestScore": 85,
  "tags": ["民法", "不法行為", "損害賠償"],
  "lawRefs": ["民法第709条", "民法第710条"],
  "court": "最高裁判所",
  "year": "2023"
}
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      final responseText = response.text;

      if (responseText == null) {
        throw Exception('AIからの応答が空です');
      }

      final jsonData = _extractJsonFromResponse(responseText);

      return DailyCase(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: jsonData['title'] ?? 'タイトル不明',
        question: jsonData['question'] ?? '',
        answerShort: jsonData['answerShort'] ?? '',
        answerLong: jsonData['answerLong'] ?? '',
        interestScore: jsonData['interestScore'] ?? 50,
        tags: List<String>.from(jsonData['tags'] ?? []),
        lawRefs: List<String>.from(jsonData['lawRefs'] ?? []),
        court: jsonData['court'] ?? '不明',
        year: jsonData['year'] ?? '不明',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      debugPrint('Daily Case生成エラー: $e');
      // フォールバック: モックデータを返す
      return _getMockDailyCase();
    }
  }

  /// Q&A応答生成
  Future<GachaResult> generateQAResponse(String question) async {
    // Vertex AI APIが無効の場合はモックデータを返す
    if (!_isVertexAIEnabled) {
      debugPrint('Vertex AI API無効: モックデータを使用');
      return _getMockGachaResult(question);
    }

    try {
      final prompt =
          '''
あなたは法律の専門家です。以下の質問に対して、法的リスクを評価し、わかりやすく回答してください。

質問: $question

以下のJSON形式で回答してください:
{
  "score": 75,
  "verdictPhrase": "ひとことで言えば...",
  "detail": "詳細な法的解説",
  "refs": ["関連する法律条文"],
  "category": "民法",
  "riskLevel": "グレー"
}

riskLevelは以下から選択:
- "OK": 法的問題なし
- "グレー": 注意が必要
- "OUT": 法的リスクが高い
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      final responseText = response.text;

      if (responseText == null) {
        throw Exception('AIからの応答が空です');
      }

      final jsonData = _extractJsonFromResponse(responseText);

      return GachaResult(
        score: jsonData['score'] ?? 50,
        verdictPhrase: jsonData['verdictPhrase'] ?? 'ひとことで言えば...',
        detail: jsonData['detail'] ?? '',
        refs: List<String>.from(jsonData['refs'] ?? []),
        category: jsonData['category'] ?? '一般',
        riskLevel: jsonData['riskLevel'] ?? 'グレー',
      );
    } catch (e) {
      debugPrint('Q&A応答生成エラー: $e');
      // フォールバック: デフォルト応答を返す
      return _getMockGachaResult(question);
    }
  }

  /// ニュース比較分析
  Future<NewsComparison> compareWithNews(
    String newsTitle,
    String newsSummary,
  ) async {
    try {
      final prompt =
          '''
以下のニュースと類似する過去の判例を分析し、比較してください。

ニュース: $newsTitle
概要: $newsSummary

類似する判例を見つけて、以下のJSON形式で回答してください:
{
  "newsTitle": "$newsTitle",
  "newsUrl": "",
  "newsSummary": "$newsSummary",
  "matchedCase": {
    "title": "類似判例のタイトル",
    "court": "裁判所名",
    "year": "年度",
    "answerShort": "判決の要旨"
  },
  "similarityScore": 0.85,
  "verdict": "類似性の評価",
  "explanation": "詳細な比較分析"
}
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      final responseText = response.text;

      if (responseText == null) {
        throw Exception('AIからの応答が空です');
      }

      final jsonData = _extractJsonFromResponse(responseText);

      // matchedCaseを適切に変換
      final matchedCaseData = jsonData['matchedCase'] as Map<String, dynamic>;
      final matchedCase = DailyCase(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: matchedCaseData['title'] ?? '',
        question: '',
        answerShort: matchedCaseData['answerShort'] ?? '',
        answerLong: '',
        interestScore: 70,
        tags: [],
        lawRefs: [],
        court: matchedCaseData['court'] ?? '',
        year: matchedCaseData['year'] ?? '',
        createdAt: DateTime.now(),
      );

      return NewsComparison(
        newsTitle: jsonData['newsTitle'] ?? newsTitle,
        newsUrl: jsonData['newsUrl'] ?? '',
        newsSummary: jsonData['newsSummary'] ?? newsSummary,
        matchedCase: matchedCase,
        similarityScore: (jsonData['similarityScore'] ?? 0.5).toDouble(),
        verdict: jsonData['verdict'] ?? '',
        explanation: jsonData['explanation'] ?? '',
      );
    } catch (e) {
      debugPrint('ニュース比較エラー: $e');
      // フォールバック: モックデータを返す
      return _getMockNewsComparison(newsTitle, newsSummary);
    }
  }

  /// レスポンスからJSONを抽出
  Map<String, dynamic> _extractJsonFromResponse(String response) {
    try {
      // JSONブロックを探す
      final jsonStart = response.indexOf('{');
      final jsonEnd = response.lastIndexOf('}') + 1;

      if (jsonStart != -1 && jsonEnd > jsonStart) {
        final jsonString = response.substring(jsonStart, jsonEnd);
        return json.decode(jsonString);
      }

      // JSONが見つからない場合は全体をパース試行
      return json.decode(response);
    } catch (e) {
      debugPrint('JSON解析エラー: $e');
      debugPrint('レスポンス: $response');
      throw Exception('AIレスポンスの解析に失敗しました');
    }
  }

  /// モックデータ（フォールバック用）
  DailyCase _getMockDailyCase() {
    return DailyCase(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '隣人の猫による庭荒らし事件',
      question: '隣人の飼い猫が毎日庭に入ってきて糞をしていく場合、法的にはどのような対応が可能でしょうか？',
      answerShort: 'ひとことで言えば、民法上の不法行為として損害賠償請求が可能です',
      answerLong:
          '隣人の猫による継続的な庭荒らしは、民法709条の不法行為に該当する可能性があります。飼い主には動物の適切な管理義務があり、これを怠った場合は損害賠償責任を負います。ただし、具体的な損害の立証と、飼い主の過失の証明が必要となります。',
      interestScore: 78,
      tags: ['民法', '不法行為', '動物', '近隣トラブル'],
      lawRefs: ['民法第709条（不法行為による損害賠償）', '民法第718条（動物の占有者等の責任）'],
      court: '東京地方裁判所',
      year: '2023',
      createdAt: DateTime.now(),
    );
  }

  GachaResult _getMockGachaResult(String question) {
    return GachaResult(
      score: 65,
      verdictPhrase: 'ひとことで言えば、注意が必要な状況です',
      detail: 'ご質問の内容について法的な検討が必要です。具体的な状況により判断が分かれる可能性があります。',
      refs: ['関連する法律条文を確認中'],
      category: '一般',
      riskLevel: 'グレー',
    );
  }

  NewsComparison _getMockNewsComparison(String newsTitle, String newsSummary) {
    final mockCase = _getMockDailyCase();
    return NewsComparison(
      newsTitle: newsTitle,
      newsUrl: '',
      newsSummary: newsSummary,
      matchedCase: mockCase,
      similarityScore: 0.7,
      verdict: '類似する判例が見つかりました',
      explanation: '提供されたニュースと類似する過去の判例を分析中です。',
    );
  }
}
