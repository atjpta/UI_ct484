import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(
    BuildContext context, String message, String title, String routeName) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Ở lại'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text('Chắc'),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(routeName);
          },
        ),
      ],
    ),
  );
}

Future<bool?> showNextDialog(
    BuildContext context, String message, String title, String routeName) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okey'),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(routeName);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(
    BuildContext context, String message, String title) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

Future<void> showLoadingDialog(
    BuildContext context, String message, String title) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
    ),
  );
}
