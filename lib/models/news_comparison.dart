import 'package:json_annotation/json_annotation.dart';
import 'daily_case.dart';

part 'news_comparison.g.dart';

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
class MatchedCase {
  final String title;
  final String court;
  final String year;
  final String answerShort;

  const MatchedCase({
    required this.title,
    required this.court,
    required this.year,
    required this.answerShort,
  });

  factory MatchedCase.fromJson(Map<String, dynamic> json) =>
      _$MatchedCaseFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedCaseToJson(this);
}
