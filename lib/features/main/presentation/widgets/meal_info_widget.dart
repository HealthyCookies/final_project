import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MealInfoWidget extends StatelessWidget {
  const MealInfoWidget({
    super.key,
    required this.index,
    required this.title,
    required this.localization,
  });

  final String title;
  final int index;
  final AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(title),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 100.0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2.0),
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(localization.mealDescriptionTitle),
                  Text(localization.mealDescriptionContent),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}