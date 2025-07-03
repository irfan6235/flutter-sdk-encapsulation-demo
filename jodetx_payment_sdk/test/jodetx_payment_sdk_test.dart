import 'package:flutter_test/flutter_test.dart';
import 'package:jodetx_payment_sdk/sdk_controller.dart';

void main() {
  test('SdkController sends result to registered callback', () {
    final controller = SdkController();
    String? callbackResult;

    controller.registerCallback((result) {
      callbackResult = result;
    });

    controller.sendResult("success:ORD123");

    expect(callbackResult, equals("success:ORD123"));
  });
}
