// lib/widgets.dart

import 'package:flutter/material.dart';
import '../models/model.dart';

// TextQuestion Widget
class TextQuestionWidget extends StatelessWidget {
  final TextQuestion question;

  TextQuestionWidget({required this.question});

  @override
  Widget build(BuildContext context) {
    return Text(
      question.questionBody,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

// ImageQuestion Widget
class ImageQuestionWidget extends StatelessWidget {
  final ImageQuestion question;

  ImageQuestionWidget({required this.question});

  @override
  Widget build(BuildContext context) {
    return Image.asset(question.imagePath);
  }
}

// MultipleChoice Widget
class MultipleChoiceWidget extends StatefulWidget {
  final MultipleChoiceAnswer answer;
  final void Function(String) onAnswerSelected;

  MultipleChoiceWidget({required this.answer, required this.onAnswerSelected});

  @override
  _MultipleChoiceWidgetState createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.answer.answerOptions.map((option) {
        return ListTile(
          title: Text(option),
          leading: Radio<String>(
            value: option,
            groupValue: _selectedAnswer,
            onChanged: (value) {
              setState(() {
                _selectedAnswer = value;
              });
              widget.onAnswerSelected(value!);
            },
          ),
        );
      }).toList(),
    );
  }
}

// TextAnswer Widget
class TextAnswerWidget extends StatelessWidget {
  final OpenTextAnswer answer;

  TextAnswerWidget({required this.answer});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Your Answer',
      ),
      onChanged: (value) {
        // Handle input
      },
    );
  }
}

// BooleanAnswer Widget
class BooleanAnswerWidget extends StatefulWidget {
  final BooleanAnswer answer;
  final void Function(String) onAnswerSelected;

  BooleanAnswerWidget({required this.answer, required this.onAnswerSelected});

  @override
  _BooleanAnswerWidgetState createState() => _BooleanAnswerWidgetState();
}

class _BooleanAnswerWidgetState extends State<BooleanAnswerWidget> {
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('True'),
          leading: Radio<String>(
            value: 'True',
            groupValue: _selectedAnswer,
            onChanged: (value) {
              setState(() {
                _selectedAnswer = value;
              });
              widget.onAnswerSelected(value!);
            },
          ),
        ),
        ListTile(
          title: Text('False'),
          leading: Radio<String>(
            value: 'False',
            groupValue: _selectedAnswer,
            onChanged: (value) {
              setState(() {
                _selectedAnswer = value;
              });
              widget.onAnswerSelected(value!);
            },
          ),
        ),
      ],
    );
  }
}

// Function to get appropriate widgets for a question
Widget questionAndAnswerView(
    Question question, void Function(String) onAnswerSelected) {
  if (question is TextQuestion) {
    if (question.answer is MultipleChoiceAnswer) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextQuestionWidget(question: question),
          SizedBox(height: 10),
          MultipleChoiceWidget(
            answer: question.answer as MultipleChoiceAnswer,
            onAnswerSelected: onAnswerSelected,
          ),
        ],
      );
    } else if (question.answer is OpenTextAnswer) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextQuestionWidget(question: question),
          SizedBox(height: 10),
          TextAnswerWidget(answer: question.answer as OpenTextAnswer),
        ],
      );
    } else if (question.answer is BooleanAnswer) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextQuestionWidget(question: question),
          SizedBox(height: 10),
          BooleanAnswerWidget(
            answer: question.answer as BooleanAnswer,
            onAnswerSelected: onAnswerSelected,
          ),
        ],
      );
    }
  } else if (question is ImageQuestion) {
    if (question.answer is MultipleChoiceAnswer) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageQuestionWidget(question: question),
          SizedBox(height: 10),
          MultipleChoiceWidget(
            answer: question.answer as MultipleChoiceAnswer,
            onAnswerSelected: onAnswerSelected,
          ),
        ],
      );
    } else if (question.answer is OpenTextAnswer) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageQuestionWidget(question: question),
          SizedBox(height: 10),
          TextAnswerWidget(answer: question.answer as OpenTextAnswer),
        ],
      );
    } else if (question.answer is BooleanAnswer) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageQuestionWidget(question: question),
          SizedBox(height: 10),
          BooleanAnswerWidget(
            answer: question.answer as BooleanAnswer,
            onAnswerSelected: onAnswerSelected,
          ),
        ],
      );
    }
  }
  throw ArgumentError('Unknown question type');
}
