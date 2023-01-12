// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/utils/auth_button.dart';
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('questions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final questionDoc = snapshot.data!.docs;

                  final questions = questionDoc
                      .map((e) => Question.fromQueryDocumentSnapshot(e))
                      .toList();

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('config')
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(snapshot.error);
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final configDoc = snapshot.data!.docs.first.data()
                          as Map<String, dynamic>;
                      final totalTime = configDoc['key'];

                      return Column(
                        children: [
                          ActionButton(
                            title: 'Start',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(
                                    totalTime: totalTime,
                                    questions: questions,
                                  ),
                                ),
                              );
                            },
                          ),
                          Gap(30),
                          Text(
                            'Total Questions: ${questions.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          )
                        ],
                      );
                    },
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
