// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:quiz_app/models/question.dart';
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
    _updateScore();
    super.initState();
  }

  Future<void> _updateScore() async {
    final authUser = FirebaseAuth.instance.currentUser;

    if (authUser == null) {
      return null;
    }

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(authUser.uid);

    final userDoc = await userRef.get();

    if (userDoc.exists) {
      final user = userDoc.data();

      if (user == null) return null;

      final lastScore = user['score'];

      if (lastScore >= widget.score) {
        return;
      }

      userRef.update({'score': widget.score});
      return;
    }

    userRef.set({
      'email': authUser.email,
      'photoUrl': authUser.photoURL,
      'score': widget.score,
      'name': authUser.displayName
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBox(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Result: ${widget.score} / ${widget.questions.length}',
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
