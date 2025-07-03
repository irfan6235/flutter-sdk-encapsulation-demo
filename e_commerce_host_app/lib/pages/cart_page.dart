import 'package:flutter/material.dart';
import 'package:jodetx_payment_sdk/jodetx_payment_sdk.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  final List<Product> cartItems;
  const CartPage({super.key, required this.cartItems});

  double get totalAmount => cartItems.fold(0, (sum, item) => sum + item.price);

  void _startPayment(BuildContext context) {
    final order = {
      'orderId': 'ORD${DateTime.now().millisecondsSinceEpoch}',
      'amount': totalAmount
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JodeTxSDK.startPayment(order, (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Payment Status: $result")),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) {
                final product = cartItems[index];
                return ListTile(
                  leading: Image.network(product.imageUrl, width: 50),
                  title: Text(product.name),
                  subtitle: Text('₹${product.price}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text('Total: ₹${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _startPayment(context),
                  child: const Text("Proceed to Pay"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
