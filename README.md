# Flutter E-Commerce SDK Demo

This project demonstrates advanced **Flutter-to-Flutter Add-to-App** integration using a precompiled `.aar` SDK and multiple Dart entrypoints. It simulates a real-world SDK encapsulation scenario where a host Flutter app communicates with a hidden Dart module.

## 🧱 Project Structure

flutter_to_flutter_demo/
├── e_commerce_host_app/ # Flutter Host App
│ ├── lib/pages/ # Cart & Order Pages
│ └── MainActivity.kt # Launches SDK using FlutterEngineGroup
└── jodetx_payment_sdk/ # Flutter SDK Module (precompiled as .aar)
└── lib/start_payment.dart

## 🎯 Features

- ✅ Multiple Dart entrypoints (host uses `main`, SDK uses `startPayment`)
- ✅ AAR-based SDK encapsulation (no Dart code visible in host)
- ✅ FlutterEngineGroup used to manage multiple Flutter runtimes
- ✅ MethodChannel communication between host and SDK
- ✅ UI Separation with individual widgets in both apps
- ✅ Simulates SDK-style hidden implementation (like closed-source SDKs)

## 🚀 How It Works

1. Host app launches `startPayment` Dart entrypoint from the precompiled SDK `.aar`.
2. SDK starts its own FlutterEngine and shows a custom UI.
3. Host–SDK communicate via MethodChannel (`com.jodetx.payment/launch`).

## 📱 Screenshots

| Host App     | SDK UI            |
| ------------ | ----------------- |
| 🛒 Cart Page | 💳 Payment Screen |

## 🛠️ Commands to Build SDK

cd jodetx_payment_sdk
flutter build aar --release

> Use `start_payment.dart` as your Dart entrypoint to precompile only the SDK logic.

## 🔗 GitHub

Repo: https://github.com/irfan6235/flutter_ecommerce_sdk_demo

## 📧 Contact

Irfan Khan  
irfan6235@gmail.com  
Built for Interview Demonstration
