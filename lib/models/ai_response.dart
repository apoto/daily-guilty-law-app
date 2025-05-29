import 'package:json_annotation/json_annotation.dart';

part 'ai_response.g.dart';

@JsonSerializable()
class AIResponse {
  final String content;
  final double? confidence;
  final List<String>? sources;
  final String? error;

  const AIResponse({
    required this.content,
    this.confidence,
    this.sources,
    this.error,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) =>
      _$AIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AIResponseToJson(this);

  factory AIResponse.error(String errorMessage) {
    return AIResponse(
      content: '',
      error: errorMessage,
    );
  }

  bool get hasError => error != null;
  bool get isSuccess => error == null && content.isNotEmpty;
}

@JsonSerializable()
class LegalQuestion {
  final String question;
  final String? category;
  final DateTime timestamp;

  const LegalQuestion({
    required this.question,
    this.category,
    required this.timestamp,
  });

  factory LegalQuestion.fromJson(Map<String, dynamic> json) =>
      _$LegalQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$LegalQuestionToJson(this);
}

@JsonSerializable()
class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  final String category;
  final String difficulty;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.category,
    required this.difficulty,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuizQuestionToJson(this);
} 