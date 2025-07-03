library jode_tx_sdk;

export 'sdk_controller.dart';

import 'package:flutter/material.dart';
import 'payment_landing.dart';
import 'sdk_controller.dart';

class JodeTxSDK {
  static Widget startPayment(
      Map<String, dynamic> order, Function(String result) onResult) {
    SdkController().registerCallback(onResult);
    return PaymentLandingPage(order: order);
  }
}
