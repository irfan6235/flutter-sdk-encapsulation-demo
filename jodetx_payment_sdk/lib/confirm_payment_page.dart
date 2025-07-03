import 'package:flutter/material.dart';
import 'sdk_controller.dart';

class ConfirmPaymentPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const ConfirmPaymentPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String orderId = order['orderId'];
    double amount = order['amount'];

    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Payment")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pay ₹${amount.toStringAsFixed(2)} for Order #$orderId"),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle_outline),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                SdkController().sendResult("success:$orderId");
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              label: const Text("Pay Now (Success)"),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.cancel_outlined),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                SdkController().sendResult("fail:Insufficient balance");
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              label: const Text("Simulate Failure"),
            ),
          ],
        ),
      ),
    );
  }
}
