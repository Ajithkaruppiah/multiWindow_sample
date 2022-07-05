import 'package:flutter/services.dart';

class TestChannel {
  /*Not used this */
  static MethodChannel channel =
      const MethodChannel("com.example.channeltest/changetext");

  TestChannel() {
    channel.setMethodCallHandler((call) async {
      if (call.method == "close") {
        print("ok");
      } else {
        print("Method not implemented: ${call.method}");
      }
    });
  }
}
