// lib/models.dart

abstract class Question {
  const Question();
}

class TextQuestion extends Question {
  final String questionBody;
  final Answer answer;
  final String id;

  const TextQuestion({
    required this.questionBody,
    required this.answer,
    required this.id,
  });

  factory TextQuestion.fromMap(Map<String, dynamic> json) {
    return TextQuestion(
      questionBody: json['questionBody'],
      answer: Answer.fromMap(json['answer']),
      id: json['id'],
    );
  }
}

class ImageQuestion extends Question {
  final String imagePath;
  final Answer answer;
  final String id;

  const ImageQuestion({
    required this.imagePath,
    required this.answer,
    required this.id,
  });

  factory ImageQuestion.fromMap(Map<String, dynamic> json) {
    return ImageQuestion(
      imagePath: json['imagePath'],
      answer: Answer.fromMap(json['answer']),
      id: json['id'],
    );
  }
}

abstract class Answer {
  const Answer();

  factory Answer.fromMap(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'openTextAnswer':
        return OpenTextAnswer.fromMap(json);
      case 'multipleChoiceAnswer':
        return MultipleChoiceAnswer.fromMap(json);
      case 'booleanAnswer':
        return BooleanAnswer.fromMap(json);
      default:
        throw FormatException('Invalid answer type');
    }
  }
}

class OpenTextAnswer extends Answer {
  final String correctAnswer;

  const OpenTextAnswer({required this.correctAnswer});

  factory OpenTextAnswer.fromMap(Map<String, dynamic> json) {
    return OpenTextAnswer(
      correctAnswer: json['correctAnswer'],
    );
  }
}

class MultipleChoiceAnswer extends Answer {
  final String correctAnswer;
  final List<String> answerOptions;

  const MultipleChoiceAnswer({
    required this.correctAnswer,
    required this.answerOptions,
  });

  factory MultipleChoiceAnswer.fromMap(Map<String, dynamic> json) {
    return MultipleChoiceAnswer(
      correctAnswer: json['correctAnswer'],
      answerOptions: List<String>.from(json['answerOptions']),
    );
  }
}

class BooleanAnswer extends Answer {
  final String correctAnswer;

  const BooleanAnswer({required this.correctAnswer});

  factory BooleanAnswer.fromMap(Map<String, dynamic> json) {
    return BooleanAnswer(
      correctAnswer: json['correctAnswer'],
    );
  }
}
