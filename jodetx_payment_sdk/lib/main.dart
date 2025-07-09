import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const channel = MethodChannel('com.jodetx.payment/launch');

// 🔴 AAR requires main()
@pragma('vm:entry-point')
void main() {
  startPayment(); // ✅ Route to correct entrypoint
}

@pragma('vm:entry-point')
void startPayment() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("🟢 Dart: startPayment launched");

  channel.setMethodCallHandler((call) async {
    if (call.method == 'launchPayment') {
      debugPrint("✅ Dart: launchPayment received");
      return "Payment UI Started";
    }
    throw MissingPluginException('Unknown method: ${call.method}');
  });

  // 🛠 Fix for view not rendering
  Future.microtask(() {
    runApp(const PaymentApp());
  });
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Jodetx Payment")),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.payment, size: 80, color: Colors.green),
              SizedBox(height: 20),
              Text("Welcome to Jodetx Payment SDK"),
            ],
          ),
        ),
      ),
    );
  }
}
