import 'package:flutter/material.dart';

class MealInfoWidget extends StatelessWidget {
  const MealInfoWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(index.toString()));
  }
}
