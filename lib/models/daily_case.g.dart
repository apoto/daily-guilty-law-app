// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_case.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyCase _$DailyCaseFromJson(Map<String, dynamic> json) => DailyCase(
      id: json['id'] as String,
      title: json['title'] as String,
      question: json['question'] as String,
      answerShort: json['answerShort'] as String,
      answerLong: json['answerLong'] as String,
      interestScore: (json['interestScore'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      lawRefs:
          (json['lawRefs'] as List<dynamic>).map((e) => e as String).toList(),
      court: json['court'] as String,
      year: json['year'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$DailyCaseToJson(DailyCase instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'question': instance.question,
      'answerShort': instance.answerShort,
      'answerLong': instance.answerLong,
      'interestScore': instance.interestScore,
      'tags': instance.tags,
      'lawRefs': instance.lawRefs,
      'court': instance.court,
      'year': instance.year,
      'createdAt': instance.createdAt.toIso8601String(),
    };

NewsComparison _$NewsComparisonFromJson(Map<String, dynamic> json) =>
    NewsComparison(
      newsTitle: json['newsTitle'] as String,
      newsUrl: json['newsUrl'] as String,
      newsSummary: json['newsSummary'] as String,
      matchedCase:
          DailyCase.fromJson(json['matchedCase'] as Map<String, dynamic>),
      similarityScore: (json['similarityScore'] as num).toDouble(),
      verdict: json['verdict'] as String,
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$NewsComparisonToJson(NewsComparison instance) =>
    <String, dynamic>{
      'newsTitle': instance.newsTitle,
      'newsUrl': instance.newsUrl,
      'newsSummary': instance.newsSummary,
      'matchedCase': instance.matchedCase,
      'similarityScore': instance.similarityScore,
      'verdict': instance.verdict,
      'explanation': instance.explanation,
    };

GachaResult _$GachaResultFromJson(Map<String, dynamic> json) => GachaResult(
      score: (json['score'] as num).toInt(),
      verdictPhrase: json['verdictPhrase'] as String,
      detail: json['detail'] as String,
      refs: (json['refs'] as List<dynamic>).map((e) => e as String).toList(),
      category: json['category'] as String,
      riskLevel: json['riskLevel'] as String,
    );

Map<String, dynamic> _$GachaResultToJson(GachaResult instance) =>
    <String, dynamic>{
      'score': instance.score,
      'verdictPhrase': instance.verdictPhrase,
      'detail': instance.detail,
      'refs': instance.refs,
      'category': instance.category,
      'riskLevel': instance.riskLevel,
    };

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) => QuizQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswerIndex: (json['correctAnswerIndex'] as num).toInt(),
      explanation: json['explanation'] as String,
      category: json['category'] as String,
      difficulty: (json['difficulty'] as num).toInt(),
      lawRefs:
          (json['lawRefs'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuizQuestionToJson(QuizQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
      'correctAnswerIndex': instance.correctAnswerIndex,
      'explanation': instance.explanation,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'lawRefs': instance.lawRefs,
    };

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
