import 'package:flutter/material.dart';
import '../../../../themes/themes.dart';

class MealInfoWidget extends StatelessWidget {
  const MealInfoWidget({
    super.key,
    required this.index,
    required this.title,
  });

  final String title;
  final int index;


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final Color borderColor = isDarkMode
        ? AppColors.textColorDark
        : AppColors.textColorLight;
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
              border: Border.all(color: borderColor ,width: 2.0),
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Meal 1'),
                  Text('Meal 2'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
