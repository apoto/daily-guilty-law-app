// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_comparison.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

MatchedCase _$MatchedCaseFromJson(Map<String, dynamic> json) => MatchedCase(
      title: json['title'] as String,
      court: json['court'] as String,
      year: json['year'] as String,
      answerShort: json['answerShort'] as String,
    );

Map<String, dynamic> _$MatchedCaseToJson(MatchedCase instance) =>
    <String, dynamic>{
      'title': instance.title,
      'court': instance.court,
      'year': instance.year,
      'answerShort': instance.answerShort,
    };
