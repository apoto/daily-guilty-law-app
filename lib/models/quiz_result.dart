import 'package:json_annotation/json_annotation.dart';

part 'quiz_result.g.dart';

@JsonSerializable()
class QuizResult {
  final String questionId;
  final int selectedAnswerIndex;
  final bool isCorrect;
  final DateTime answeredAt;
  final int timeSpentSeconds;

  const QuizResult({
    required this.questionId,
    required this.selectedAnswerIndex,
    required this.isCorrect,
    required this.answeredAt,
    required this.timeSpentSeconds,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultToJson(this);
}
