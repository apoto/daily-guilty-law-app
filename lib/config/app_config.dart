import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get projectId => dotenv.env['GOOGLE_CLOUD_PROJECT_ID'] ?? '';
  static String get region =>
      dotenv.env['GOOGLE_CLOUD_REGION'] ?? 'asia-northeast1';
  static String get vertexAiEndpoint => dotenv.env['VERTEX_AI_ENDPOINT'] ?? '';
  static String get agentEngineEndpoint =>
      dotenv.env['AGENT_ENGINE_ENDPOINT'] ?? '';

  // Vertex AI Models
  static String get textModel => 'gemini-1.5-flash-001';
  static String get embeddingModel => 'text-embedding-gecko-multilingual@001';

  // App Features
  static int get dailyCacheHours => 24;
  static int get freeGachaLimit => 5;
  static double get similarityThreshold => 0.3;

  static bool get isProduction => const bool.fromEnvironment('dart.vm.product');
}
