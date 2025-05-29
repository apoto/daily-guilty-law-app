// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponse _$AIResponseFromJson(Map<String, dynamic> json) => AIResponse(
  content: json['content'] as String,
  confidence: (json['confidence'] as num?)?.toDouble(),
  sources: (json['sources'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  error: json['error'] as String?,
);

Map<String, dynamic> _$AIResponseToJson(AIResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'confidence': instance.confidence,
      'sources': instance.sources,
      'error': instance.error,
    };

LegalQuestion _$LegalQuestionFromJson(Map<String, dynamic> json) =>
    LegalQuestion(
      question: json['question'] as String,
      category: json['category'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$LegalQuestionToJson(LegalQuestion instance) =>
    <String, dynamic>{
      'question': instance.question,
      'category': instance.category,
      'timestamp': instance.timestamp.toIso8601String(),
    };

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) => QuizQuestion(
  id: json['id'] as String,
  question: json['question'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  correctAnswer: (json['correctAnswer'] as num).toInt(),
  explanation: json['explanation'] as String,
  category: json['category'] as String,
  difficulty: json['difficulty'] as String,
);

Map<String, dynamic> _$QuizQuestionToJson(QuizQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
      'category': instance.category,
      'difficulty': instance.difficulty,
    };
