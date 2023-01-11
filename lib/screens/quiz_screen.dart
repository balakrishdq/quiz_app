// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/utils/gradient_box.dart';

import '../widgets/answer_tile.dart';

class QuizScreen extends StatefulWidget {
  final int totalTime;
  final List<Question> questions;
  const QuizScreen({
    Key? key,
    required this.totalTime,
    required this.questions,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int _currentTime;

  late Timer _timer;

  int _currentIndex = 0;

  String _selectedAnswer = '';

  int _score = 0;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.totalTime;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print(_currentTime);
      setState(() {
        _currentTime -= 1;
      });

      if (_currentTime == 0) {
        _timer.cancel();
        pushResultScreen(context);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentIndex];
    return Scaffold(
      body: GradientBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(40),
              SizedBox(
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      LinearProgressIndicator(
                        value: _currentTime / widget.totalTime,
                      ),
                      Center(
                        child: Text(
                          _currentTime.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(40),
              Text(
                'Question',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Gap(10),
              Text(
                currentQuestion.question,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final answer = currentQuestion.answers[index];
                    return AnswerTile(
                      isSelected: answer == _selectedAnswer,
                      answer: answer,
                      correctAnswer: currentQuestion.correctAnswer,
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            _selectedAnswer = answer;
                          });
                        });
                        if (answer == currentQuestion.correctAnswer) {
                          _score++;
                        }

                        Future.delayed(Duration(milliseconds: 200), () {
                          if (_currentIndex == widget.questions.length - 1) {
                            pushResultScreen(context);
                            return;
                          }
                          setState(() {
                            _currentIndex++;
                            _selectedAnswer = '';
                          });
                        });
                      },
                    );
                  },
                  itemCount: currentQuestion.answers.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
            questions: widget.questions,
            totalTime: widget.totalTime,
            score: _score),
      ),
    );
  }
}
