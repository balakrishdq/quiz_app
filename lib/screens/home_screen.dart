// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/utils/auth_button.dart';
import 'package:quiz_app/utils/gradient_box.dart';

import '../utils/action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    return Scaffold(
      body: SizedBox.expand(
        child: GradientBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
              Image.asset('assets/images/logo1.png'),
              Gap(40),
              if (provider.questions.isEmpty || provider.totalTime == 0)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                ActionButton(
                  title: 'Start',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          totalTime: provider.totalTime,
                          questions: provider.questions,
                        ),
                      ),
                    );
                  },
                ),
              Gap(30),
              Text(
                'Total Questions: ${provider.questions.length}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              Gap(40),
              AuthButton(),
            ],
          ),
        ),
      ),
    );
  }
}
