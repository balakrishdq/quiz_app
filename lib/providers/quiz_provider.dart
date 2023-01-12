import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_user.dart';
import 'package:quiz_app/services/quiz_service.dart';

import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  int totalTime = 0;
  List<Question> questions = [];
  List<QuizUser?> users = [];

  QuizProvider() {
    QuizService.getAllQuestions().then((value) {
      questions = value;
      notifyListeners();
    });

    QuizService.getTotalTime().then((value) {
      totalTime = value;
      notifyListeners();
    });
  }

  Future<void> getAllUsers() async {
    users = await QuizService?.getAllUser();
    notifyListeners();
  }

  Future<void> updateScore(int currentScore) async {
    await QuizService.updateScore(currentScore);
  }
}
