// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/utils/gradient_box.dart';

import '../utils/action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: GradientBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Mania',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              Gap(40),
              ActionButton(
                title: 'Start',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        totalTime: 10,
                        questions: questions,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}