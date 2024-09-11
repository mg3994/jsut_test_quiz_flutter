// lib/main.dart

import 'package:flutter/material.dart';

import 'data/data.dart';
import 'models/model.dart';
import 'widgets/widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<Question>> _questionsFuture;
  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _questionsFuture = loadQuestions();
  }

  void _submitAnswer(String answer) {
    _questionsFuture.then((questions) {
      final question = questions[_currentQuestionIndex];
      final correctAnswer = (question as dynamic).answer.correctAnswer;
      if (answer == correctAnswer) {
        setState(() {
          _score++;
        });
      }

      setState(() {
        _currentQuestionIndex++;
      });

      if (_currentQuestionIndex >= questions.length) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScorePage(score: _score),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: FutureBuilder<List<Question>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No questions available'));
          }

          final questions = snapshot.data!;
          if (_currentQuestionIndex >= questions.length) {
            return Center(child: Text('Quiz is finished!'));
          }

          final question = questions[_currentQuestionIndex];
          return Padding(
            padding: EdgeInsets.all(16),
            child: questionAndAnswerView(
              question,
              _submitAnswer,
            ),
          );
        },
      ),
    );
  }
}

class ScorePage extends StatelessWidget {
  final int score;

  ScorePage({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Score')),
      body: Center(
        child: Text(
          'Your score is: $score',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
