// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResult _$QuizResultFromJson(Map<String, dynamic> json) => QuizResult(
      questionId: json['questionId'] as String,
      selectedAnswerIndex: (json['selectedAnswerIndex'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool,
      answeredAt: DateTime.parse(json['answeredAt'] as String),
      timeSpentSeconds: (json['timeSpentSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$QuizResultToJson(QuizResult instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'selectedAnswerIndex': instance.selectedAnswerIndex,
      'isCorrect': instance.isCorrect,
      'answeredAt': instance.answeredAt.toIso8601String(),
      'timeSpentSeconds': instance.timeSpentSeconds,
    };
