import 'package:json_annotation/json_annotation.dart';

part 'gacha_result.g.dart';

@JsonSerializable()
class GachaResult {
  final int score;
  final String verdictPhrase;
  final String detail;
  final List<String> refs;
  final String category;
  final String riskLevel;

  const GachaResult({
    required this.score,
    required this.verdictPhrase,
    required this.detail,
    required this.refs,
    required this.category,
    required this.riskLevel,
  });

  factory GachaResult.fromJson(Map<String, dynamic> json) =>
      _$GachaResultFromJson(json);

  Map<String, dynamic> toJson() => _$GachaResultToJson(this);
}
