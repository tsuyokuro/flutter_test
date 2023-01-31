import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "view/register_device_page.dart";
import "view/pincode_page.dart";
import "constants/constants.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: LightMode.appThemeData,
      home: const MyHomePage(title: 'Riverpod Test'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const MyBody(),
    );
  }
}

class MyBody extends StatelessWidget {
  const MyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterDevicePage()));
          },
          style: LightMode.buttonStyle,
          child: const Text("Register Device")),
      const SizedBox(height: 8),
      ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PinCodePage()));
          },
          child: const Text("PinCodePage")),
    ]));
  }
}
