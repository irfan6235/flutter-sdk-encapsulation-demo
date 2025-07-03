import 'package:flutter/material.dart';
import 'confirm_payment_page.dart';

class PaymentLandingPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const PaymentLandingPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("JodeTx - Payment Gateway")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Amount: ₹${order['amount']}",
                style: const TextStyle(fontSize: 20)),
            Text("Order ID: ${order['orderId']}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Proceed to Confirm"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConfirmPaymentPage(order: order),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
