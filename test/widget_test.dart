import 'package:flutter_test/flutter_test.dart';
import 'package:sick_bay/main.dart';

void main() {
  testWidgets('Sick Bay app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const SickBayApp());

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('World Clock'), findsOneWidget);
  });
}
