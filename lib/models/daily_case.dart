import 'package:json_annotation/json_annotation.dart';

part 'daily_case.g.dart';

@JsonSerializable()
class DailyCase {
  final String id;
  final String title;
  final String question;
  final String answerShort;
  final String answerLong;
  final int interestScore;
  final List<String> tags;
  final List<String> lawRefs;
  final String court;
  final String year;
  final DateTime createdAt;

  const DailyCase({
    required this.id,
    required this.title,
    required this.question,
    required this.answerShort,
    required this.answerLong,
    required this.interestScore,
    required this.tags,
    required this.lawRefs,
    required this.court,
    required this.year,
    required this.createdAt,
  });

  factory DailyCase.fromJson(Map<String, dynamic> json) =>
      _$DailyCaseFromJson(json);

  Map<String, dynamic> toJson() => _$DailyCaseToJson(this);
}
