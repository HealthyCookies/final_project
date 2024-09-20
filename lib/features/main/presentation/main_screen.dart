import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import 'widgets/caloric_intake_widget.dart';
import 'widgets/meal_info_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Bounceable(
              onTap: () {
                log('Navigate to add screen');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Icon(Icons.add_rounded),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: CaloricIntakeWidget()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return MealInfoWidget(index: index);
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
