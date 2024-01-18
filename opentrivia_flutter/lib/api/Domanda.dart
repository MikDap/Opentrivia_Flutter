import 'package:json_annotation/json_annotation.dart';

part 'Domanda.g.dart';

@JsonSerializable()
class Domanda {
  final String? category;
  final String? type;
  final String? difficulty;
  final String? question;
  final String? correct_answer;
  final List<String>? incorrect_answers;

  Domanda({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correct_answer,
    this.incorrect_answers,
  });

  factory Domanda.fromJson(Map<String, dynamic> json) => _$DomandaFromJson(json);

  Map<String, dynamic> toJson() => _$DomandaToJson(this);
}
