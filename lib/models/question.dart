// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  final String id;
  final String question;
  final List<String> answers;
  final String correctAnswer;
  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  Question copyWith({
    String? id,
    String? question,
    List<String>? answers,
    String? correctAnswer,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answers': answers,
      'correctAnswer': correctAnswer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      question: map['question'] as String,
      answers: List<String>.from(map['answers'] as List<String>),
      correctAnswer: map['correctAnswer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answers: $answers, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question == question &&
        listEquals(other.answers, answers) &&
        other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        answers.hashCode ^
        correctAnswer.hashCode;
  }
}

List<Question> questions = [
  Question(
    id: '1',
    question: 'The metal whose salts are sensitive to light is?',
    answers: [
      'Zinc',
      'Silver',
      'Copper',
      'Aluminium',
    ],
    correctAnswer: 'Silver',
  ),
  Question(
    id: '2',
    question: 'Patanjali is well known for compilation of -',
    answers: [
      'Yoga Sutra',
      'Panchatantra',
      'Brahma Sutra',
      'Ayurveda',
    ],
    correctAnswer: 'Yoga Sutra',
  ),
  Question(
    id: '3',
    question: 'The country that has the highest in Barley Production?',
    answers: [
      'China',
      'India',
      'Russia',
      'France',
    ],
    correctAnswer: 'Russia',
  ),
  Question(
    id: '4',
    question: 'Tsunami are not caused by',
    answers: [
      'Hurricanes',
      'Earthquakes',
      'Undersea landslides',
      'Volcanic Eruptions',
    ],
    correctAnswer: 'Hurricanes',
  ),
  Question(
    id: '5',
    question: 'Chambal river is a part of',
    answers: [
      'Sabarmati basin',
      'Ganga basin',
      'Narmada basin',
      'Godavari basin'
    ],
    correctAnswer: 'Narmada basin',
  ),
];
