import 'package:flutter/material.dart';
import 'package:mymovies_app/src/theme/theme.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error', style: TextStyle(color: myTheme.primaryColor)),
        content: Text(message, style: Theme.of(context).textTheme.subtitle2),
        actions: [
          TextButton(
            child: Text('Ok', style: TextStyle(color: myTheme.primaryColor)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    },
  );
}