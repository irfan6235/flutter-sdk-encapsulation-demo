class SdkController {
  static final SdkController _instance = SdkController._internal();
  factory SdkController() => _instance;
  SdkController._internal();

  late Function(String result) _onPaymentDone;

  void registerCallback(Function(String result) callback) {
    _onPaymentDone = callback;
  }

  void sendResult(String result) {
    _onPaymentDone(result);
  }
}
