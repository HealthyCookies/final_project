import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../features/l10n/s.dart';
import '../../../../themes/themes.dart';

Future<bool> showConfirmDialog(BuildContext context) async {
  final String title = S.of(context).showConfirmDialogSure;
  final String denyText = S.of(context).showConfirmDialogCancel;
  final String confirmText = S.of(context).showConfirmDialogContinue;
  const String bodyText = '';
  bool agreed = false;
  final ThemeData theme = Theme.of(context);
  final bool isDarkMode = theme.brightness == Brightness.dark;
  final Color textColor = isDarkMode
      ? AppColors.textColorDark
      : AppColors.textColorLight;
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: const Text(bodyText),
      actions: <Widget>[
        TextButton(
          onPressed: context.maybePop,
          child: Text(denyText, style: TextStyle(color: textColor)),
        ),
        TextButton(
          onPressed: () {
            agreed = true;
            context.maybePop();
          },
          child: Text(confirmText, style: TextStyle(color: textColor)),
        ),
      ],
    ),
  );

  return agreed;
}
