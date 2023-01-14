// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/utils/action_button.dart';
import 'package:quiz_app/utils/auth_button.dart';
import 'package:quiz_app/utils/gradient_box.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalTime;
  final List<Question> questions;
  const ResultScreen({
    Key? key,
    required this.score,
    required this.totalTime,
    required this.questions,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<QuizProvider>();
    provider.updateScore(widget.score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.indigo.shade800,
                Colors.indigo.shade800,
              ],
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
            },
            icon: Icon(
              Icons.home,
            )),
      ),
      body: GradientBox(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score: ${widget.score} / ${widget.questions.length}',
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
                      builder: (context) => QuizScreen(
                        totalTime: widget.totalTime,
                        questions: widget.questions,
                      ),
                    ),
                  );
                },
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
