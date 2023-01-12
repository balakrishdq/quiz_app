import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/utils/gradient_box.dart';

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
      body: GradientBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Gap(40),
              Text(
                'Leaderboard',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (provider.users.isEmpty)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    final users = provider.users[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            users.photoUrl,
                          ),
                        ),
                        title: Text(
                          users.name,
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
                ))
            ],
          ),
        ),
      ),
    );
  }
}
