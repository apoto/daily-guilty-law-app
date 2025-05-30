import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_case.dart';
import '../models/news_comparison.dart';
import '../models/gacha_result.dart';
import '../services/vertex_ai_service.dart';

// Dio provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  return dio;
});

// Vertex AI サービスプロバイダー
final vertexAIServiceProvider = Provider<VertexAIService>((ref) {
  return VertexAIService();
});

// Mock data for development
final mockDailyCase = DailyCase(
  id: 'mock-001',
  title: '猫の餌やりで隣人トラブル！法的責任はどこまで？',
  question: '野良猫に餌をあげていたら、隣人から「猫が庭を荒らす」と苦情が。法的に責任を負うのでしょうか？',
  answerShort: 'ひとことで言えば...餌やりには一定の責任が伴います！',
  answerLong: '''野良猫への餌やりは、動物愛護の観点から良い行為ですが、法的には注意が必要です。

継続的な餌やりにより事実上の飼い主とみなされる場合があり、その猫が他人の財産に損害を与えた際は損害賠償責任を負う可能性があります。

実際の判例では、餌やりを続けていた人が猫による被害の賠償を命じられたケースもあります。

対策として：
• 地域猫活動として正式に取り組む
• 近隣住民との合意形成
• 避妊去勢手術の実施
などが重要です。''',
  interestScore: 85,
  tags: ['動物', '近隣トラブル', '損害賠償', '民法'],
  lawRefs: ['民法第709条（不法行為）', '動物の愛護及び管理に関する法律'],
  court: '東京地裁',
  year: '2023',
  createdAt: DateTime.now(),
);

// Daily case provider with mock data fallback
final dailyCaseProvider = FutureProvider<DailyCase>((ref) async {
  final vertexAIService = ref.read(vertexAIServiceProvider);
  return await vertexAIService.generateDailyCase();
});

// News comparisons provider with mock data fallback
final newsComparisonsProvider = FutureProvider<List<NewsComparison>>((
  ref,
) async {
  // モックデータを返す
  await Future.delayed(const Duration(seconds: 1));
  return [
    NewsComparison(
      newsTitle: '自動運転車の事故、責任の所在は？',
      newsUrl: 'https://example.com/news/1',
      newsSummary: '自動運転車による交通事故が発生。運転者と製造者の責任について議論が活発化。',
      matchedCase: mockDailyCase,
      similarityScore: 0.75,
      verdict: '製造物責任と運転者責任の複合的判断が必要',
      explanation: '自動運転技術の発展に伴い、従来の交通事故とは異なる法的判断が求められています。',
    ),
  ];
});

// Gacha result provider with mock data fallback
final gachaResultProvider = FutureProvider.family<GachaResult, String>((
  ref,
  query,
) async {
  // モックデータを返す
  await Future.delayed(const Duration(seconds: 2));
  return GachaResult(
    score: 65,
    verdictPhrase: 'ひとことで言えば...グレーゾーンです！',
    detail:
        'あなたの質問「$query」について分析した結果、法的にはグレーゾーンの可能性があります。詳細な状況により判断が分かれるケースです。',
    refs: ['民法第709条', '刑法第○○条'],
    category: '民事・刑事複合',
    riskLevel: 'グレー',
  );
});

// Selected index for bottom navigation
final selectedIndexProvider = StateProvider<int>((ref) => 0);

// Q&A 応答プロバイダー
final qaResponseProvider = FutureProvider.family<GachaResult, String>((
  ref,
  question,
) async {
  final vertexAIService = ref.read(vertexAIServiceProvider);
  return await vertexAIService.generateQAResponse(question);
});

// ニュース比較プロバイダー
final newsComparisonProvider =
    FutureProvider.family<NewsComparison, Map<String, String>>((
      ref,
      params,
    ) async {
      final vertexAIService = ref.read(vertexAIServiceProvider);
      return await vertexAIService.compareWithNews(
        params['title'] ?? '',
        params['summary'] ?? '',
      );
    });

// ローディング状態管理
final isLoadingProvider = StateProvider<bool>((ref) => false);
