import 'package:flutter/material.dart';
import 'product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ShopEasy")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Start Shopping"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductListPage()),
            );
          },
        ),
      ),
    );
  }
}
