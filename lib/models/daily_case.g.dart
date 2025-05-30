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
