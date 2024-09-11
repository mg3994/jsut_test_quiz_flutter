// lib/data.dart

import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

import '../models/model.dart';

String questions = '''[
  {
    "type": "textQuestion",
    "questionBody": "What is the capital of France?",
    "answer": {
      "type": "multipleChoiceAnswer",
      "correctAnswer": "Paris",
      "answerOptions": ["Paris", "London", "Berlin", "Madrid"]
    },
    "id": "q1"
  },
  {
    "type": "imageQuestion",
    "imagePath": "assets/sample_image.png",
    "answer": {
      "type": "booleanAnswer",
      "correctAnswer": "True"
    },
    "id": "q2"
  }
]
''';

Future<List<Question>> loadQuestions() async {
  // final String response = await rootBundle.loadString('assets/questions.json');
  final List<dynamic> data = json.decode(questions);

  return data.map<Question>((json) {
    switch (json['type']) {
      case 'textQuestion':
        return TextQuestion.fromMap(json);
      case 'imageQuestion':
        return ImageQuestion.fromMap(json);
      default:
        throw FormatException('Unknown question type');
    }
  }).toList();
}
