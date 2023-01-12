// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isPrimary;
  const ActionButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: isPrimary
          ? ElevatedButton(
              onPressed: () => onTap(),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : TextButton(
              onPressed: () => onTap(),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              )),
    );
  }
}
