// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gacha_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
