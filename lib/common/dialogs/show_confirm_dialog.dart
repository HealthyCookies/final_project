import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../features/l10n/s.dart';

Future<bool> showConfirmDialog(BuildContext context) async {
  final String title = S.of(context).showConfirmDialogSure;
  final String denyText = S.of(context).showConfirmDialogCancel;
  final String confirmText = S.of(context).showConfirmDialogContinue;
  const String bodyText = '';
  bool agreed = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: const Text(bodyText),
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
