import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/pincode_notifier.dart';
import '../ui_component/ten_key.dart';

final pinCodeNotifierProvider =
    StateNotifierProvider<PinCodeNotifier, String>((ref) {
  return PinCodeNotifier();
});

class PinCodePage extends StatelessWidget {
  const PinCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PINコード入力"),
      ),
      body: const PinCodePageBody(),
    );
  }
}

class PinCodePageBody extends StatelessWidget {
  const PinCodePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: w,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Consumer(
              builder: (context, ref, child) {
                String s = ref.watch(pinCodeNotifierProvider);
                return SizedBox(
                  width: 56 * 3,
                  height: 56,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          s),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Consumer(builder: ((context, ref, _) {
              var notifier = ref.read(pinCodeNotifierProvider.notifier);
              return TenKey(pinCodeNotifier: notifier);
            })),
          ]),
        ),
      ),
    );
  }
}
