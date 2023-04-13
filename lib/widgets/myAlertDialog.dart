import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog(
      {super.key,
      required this.content,
      required this.message,
      this.buttonText = "Close",
      required this.onPressed});

  final String message;
  final void Function() onPressed;
  final String content;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message),
      content: SingleChildScrollView(child: Text(content)),
      actions: [
        ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        )
      ],
    );
  }
}
