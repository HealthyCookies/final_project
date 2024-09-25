import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:final_project/main.dart' as app;

void main() {

  testWidgets('App launches and displays the home screen', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    expect(find.text('Main'), findsOneWidget);
  });
}
