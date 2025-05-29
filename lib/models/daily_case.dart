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

@JsonSerializable()
class NewsComparison {
  final String newsTitle;
  final String newsUrl;
  final String newsSummary;
  final DailyCase matchedCase;
  final double similarityScore;
  final String verdict;
  final String explanation;

  const NewsComparison({
    required this.newsTitle,
    required this.newsUrl,
    required this.newsSummary,
    required this.matchedCase,
    required this.similarityScore,
    required this.verdict,
    required this.explanation,
  });

  factory NewsComparison.fromJson(Map<String, dynamic> json) =>
      _$NewsComparisonFromJson(json);

  Map<String, dynamic> toJson() => _$NewsComparisonToJson(this);
}

@JsonSerializable()
class GachaResult {
  final int score;
  final String verdictPhrase;
  final String detail;
  final List<String> refs;
  final String category;
  final String riskLevel; // "OK", "グレー", "OUT"

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
