import 'package:final_project/common/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DefaultTextFormField golden test', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DefaultTextFormField(
            labelText: 'Enter text',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.byType(DefaultTextFormField),
      matchesGoldenFile('golden/default_text_form_field.png'),
    );
  });
}
