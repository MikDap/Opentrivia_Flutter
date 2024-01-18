// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Domanda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Domanda _$DomandaFromJson(Map<String, dynamic> json) => Domanda(
      category: json['category'] as String?,
      type: json['type'] as String?,
      difficulty: json['difficulty'] as String?,
      question: json['question'] as String?,
      correct_answer: json['correct_answer'] as String?,
      incorrect_answers: (json['incorrect_answers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DomandaToJson(Domanda instance) => <String, dynamic>{
      'category': instance.category,
      'type': instance.type,
      'difficulty': instance.difficulty,
      'question': instance.question,
      'correctAnswer': instance.correct_answer,
      'incorrectAnswers': instance.incorrect_answers,
    };
