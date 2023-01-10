// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/utils/action_button.dart';

import 'package:quiz_app/utils/gradient_box.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  const ResultScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBox(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Result: $score / $totalQuestions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              Gap(40),
              ActionButton(
                title: 'Try Again',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizScreen(totalTime: 10, questions: questions),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
