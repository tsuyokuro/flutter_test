import 'package:flutter_riverpod/flutter_riverpod.dart';

// PIN Code
class PinCodeNotifier extends StateNotifier<String> {
  PinCodeNotifier() : super("");

  void newState(String s) {
    state = s;
  }

  String getState() => state;
}
