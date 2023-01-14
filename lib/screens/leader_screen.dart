import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/services/quiz_service.dart';
import 'package:quiz_app/utils/gradient_box.dart';

import '../services/auth_service.dart';

class LeaderScreen extends StatefulWidget {
  const LeaderScreen({super.key});

  @override
  State<LeaderScreen> createState() => _LeaderScreenState();
}

class _LeaderScreenState extends State<LeaderScreen> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<QuizProvider>();
    provider.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
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
        centerTitle: true,
        title: Text(
          'Leaderboard',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOut(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: GradientBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Gap(10),
              if (provider.users.isEmpty)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: QuizService.getAllUser,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final users = provider.users[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              users!.photoUrl.toString(),
                            ),
                          ),
                          title: Text(
                            users.name.toString(),
                          ),
                          trailing: Text(
                            users.score.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: provider.users.length,
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
