import 'package:json_annotation/json_annotation.dart';

part 'study_card.g.dart';

@JsonSerializable()
class StudyCard {
  final String id;
  final String front;
  final String back;
  final String category;
  final String difficulty;
  final List<String> tags;

  const StudyCard({
    required this.id,
    required this.front,
    required this.back,
    required this.category,
    required this.difficulty,
    required this.tags,
  });

  factory StudyCard.fromJson(Map<String, dynamic> json) =>
      _$StudyCardFromJson(json);

  Map<String, dynamic> toJson() => _$StudyCardToJson(this);
}
