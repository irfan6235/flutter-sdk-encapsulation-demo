import 'package:flutter_test/flutter_test.dart';

import 'package:e_commerce_host_app/main.dart';

void main() {
  testWidgets('Home screen button opens product page',
      (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(const ShopEasyApp());

    // Check that the "Start Shopping" button exists.
    expect(find.text('Start Shopping'), findsOneWidget);

    // Tap the button.
    await tester.tap(find.text('Start Shopping'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the ProductListPage.
    expect(find.text('Shop Easy - Products'), findsOneWidget);
  });
}
