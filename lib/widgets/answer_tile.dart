import 'package:flutter/material.dart';

class AnswerTile extends StatelessWidget {
  final bool isSelected;
  final String answer;
  final String correctAnswer;
  final Function onTap;

  const AnswerTile({
    Key? key,
    required this.isSelected,
    required this.answer,
    required this.correctAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: ListTile(
        onTap: () => onTap(),
        title: Text(
          answer,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Color get cardColor {
    if (!isSelected) {
      return Colors.white;
    }
    if (answer == correctAnswer) {
      return Colors.greenAccent;
    }
    return Colors.redAccent;
  }
}
