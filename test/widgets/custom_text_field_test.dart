import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/presentation/widgets/custom_text_field.dart';
import '../test_helpers.dart';

void main() {
  group('CustomTextField', () {
    testWidgets('displays hint text correctly', (WidgetTester tester) async {
      const testHint = 'Enter your name';

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const CustomTextField(hintText: testHint),
        ),
      );

      // Verify hint text is displayed
      expect(find.text(testHint), findsOneWidget);
    });

    testWidgets('displays prefix icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const CustomTextField(hintText: 'Search', prefixIcon: Icons.search),
        ),
      );

      // Verify icon is displayed
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('does not display prefix icon when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const CustomTextField(hintText: 'Test'),
        ),
      );

      // Verify TextFormField exists
      expect(find.byType(TextFormField), findsOneWidget);

      // Icon should not be present
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('allows text input', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const CustomTextField(hintText: 'Type here'),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextFormField), 'Test input');

      // Verify text is entered
      expect(find.text('Test input'), findsOneWidget);
    });
  });
}
