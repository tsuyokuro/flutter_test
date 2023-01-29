import 'package:flutter/material.dart';
import '../view_model/pincode_notifier.dart';

class TenKey extends StatelessWidget {
  final List<int> keys = <int>[];
  final PinCodeNotifier pinCodeNotifier;

  // Diemtions
  static double btnPadding = 4;
  static double btnW = 48;
  static double btnH = 32;
  static double btnTerritoryW = btnW + btnPadding * 2;
  static double btnTerritoryH = btnH + btnPadding * 2;
  static double padW = btnTerritoryW * 3;
  static double padH = btnTerritoryH * 4;

  TenKey({super.key, bool random = false, required this.pinCodeNotifier}) {
    keys.clear();
    for (int i = 1; i <= 10; i++) {
      keys.add(i % 10);
    }

    if (random) {}
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> lines = <Widget>[];

    int cnt = 0;

    for (int y = 0; y < 4; y++) {
      List<Widget> line = <Widget>[];

      for (int x = 0; x < 3 && cnt < 10; x++) {
        int idx = cnt;

        line.add(SizedBox(
          width: btnTerritoryW,
          height: btnTerritoryH,
          child: Padding(
            padding: EdgeInsets.all(btnPadding),
            child: ElevatedButton(
                onPressed: () {
                  String s = pinCodeNotifier.getState();
                  if (s.length < 4) {
                    pinCodeNotifier.newState("$s${keys[idx]}");
                  }
                },
                child: Text("${keys[idx]}")),
          ),
        ));

        cnt++;
      }

      if (cnt == 10) {
        line.add(SizedBox(
          width: btnTerritoryW * 2,
          height: btnTerritoryH,
          child: Padding(
            padding: EdgeInsets.all(btnPadding),
            child: ElevatedButton(
                onPressed: () {
                  pinCodeNotifier.newState("");
                },
                child: const Text("Clear")),
          ),
        ));
      }

      lines.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: line,
      ));
    }

    return SizedBox(
      width: padW,
      height: padH,
      child: Column(
        children: lines,
      ),
    );
  }
}
