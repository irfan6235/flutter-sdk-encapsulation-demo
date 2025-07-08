import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const channel = MethodChannel('com.jodetx.payment/launch');

@pragma(
    'vm:entry-point') // 🔑 Required for Dart VM to find this function in AOT
void main() {
  startPayment(); // 🔄 You may call your real logic here
}

void startPayment() {
  WidgetsFlutterBinding.ensureInitialized();

  // Handle method calls from native Android
  channel.setMethodCallHandler((call) async {
    if (call.method == 'launchPayment') {
      debugPrint('✅ Dart: launchPayment received from native.');
      return "Payment UI Started";
    }
    throw MissingPluginException('Unknown method: ${call.method}');
  });

  debugPrint('🟢 Dart isolate started');
  channel.invokeMethod('dartReady');

  runApp(const PaymentApp());
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.payment, size: 80, color: Colors.green),
              SizedBox(height: 20),
              Text(
                "Welcome to Jodetx Payment SDK",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
