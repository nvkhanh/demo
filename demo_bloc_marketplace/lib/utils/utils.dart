import 'package:flutter/material.dart';

class Utils {
  static void showDefaultDialog(BuildContext context, Widget title, Widget description) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title,
          content: description,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}