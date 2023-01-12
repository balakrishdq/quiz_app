import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/models/question.dart';

import '../models/quiz_user.dart';

class QuizService {
  static Future<List<Question>> getAllQuestions() async {
    final questionRef = FirebaseFirestore.instance.collection('questions');
    final questionDoc = await questionRef.get();

    return questionDoc.docs
        .map((e) => Question.fromQueryDocumentSnapshot(e))
        .toList();
  }

  static Future<int> getTotalTime() async {
    final configRef = FirebaseFirestore.instance.collection('config');
    final configDoc = await configRef.get();

    final config = configDoc.docs.first.data();
    return config['key'];
  }

  static Future<List<QuizUser>> getAllUser() async {
    final userRef = FirebaseFirestore.instance.collection('questions');
    final userDoc = await userRef.get();

    return userDoc.docs
        .map((e) => QuizUser.fromQueryDocumentSnapshot(e))
        .toList();
  }

  static Future<void> updateScore(int currentScore) async {
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

      if (lastScore >= currentScore) {
        return;
      }

      userRef.update({'score': currentScore});
      return;
    }

    userRef.set({
      'email': authUser.email,
      'photoUrl': authUser.photoURL,
      'score': currentScore,
      'name': authUser.displayName
    });
  }
}
