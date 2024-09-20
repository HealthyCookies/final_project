import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  String title = 'Are you sure?',
  String denyText = 'Cancel',
  String confirmText = 'Continue',
  String bodyText = '',
}) async {
  bool agreed = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(bodyText),
      actions: <Widget>[
        TextButton(
          onPressed: context.maybePop,
          child: Text(denyText),
        ),
        TextButton(
          onPressed: () {
            agreed = true;
            context.maybePop();
          },
          child: Text(confirmText),
        ),
      ],
    ),
  );

  return agreed;
}
