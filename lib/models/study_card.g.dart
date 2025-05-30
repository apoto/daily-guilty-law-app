// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyCard _$StudyCardFromJson(Map<String, dynamic> json) => StudyCard(
      id: json['id'] as String,
      front: json['front'] as String,
      back: json['back'] as String,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$StudyCardToJson(StudyCard instance) => <String, dynamic>{
      'id': instance.id,
      'front': instance.front,
      'back': instance.back,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'tags': instance.tags,
    };
