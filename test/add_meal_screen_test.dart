import 'package:final_project/common/widgets/default_text_form_filed.dart';
import 'package:final_project/features/main/presentation/screens/add_meal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Test AddMealScreen',
    () {
      testWidgets('Displays the correct title and fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: AddMealScreen(),
        ));

        expect(
          find.text(
              'Input the dish name, its type (Breakfast, Lunch, Dinner) and Calories'),
          findsOneWidget,
        );

        expect(find.byType(DefaultTextFormField), findsNWidgets(3));

        final Finder nameField =
            find.widgetWithText(DefaultTextFormField, 'Name');
        expect(nameField, findsOneWidget);

        expect(find.byIcon(Icons.arrow_back), findsOneWidget);

        expect(find.byType(FloatingActionButton), findsOneWidget);
      });
    },
  );
}
