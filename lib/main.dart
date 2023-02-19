import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "constants/constants.dart";
import "router/router.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// APP
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter Test',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST"),
      ),
      body: const SingleChildScrollView(child: MyBody()),
    );
  }
}

class MyBody extends ConsumerWidget {
  const MyBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
          onPressed: () {
            router.push("/RegisterDevice");
          },
          style: LightMode.buttonStyle,
          child: const Text("Register Device")),
      const SizedBox(height: 8),
      ElevatedButton(
          onPressed: () {
            router.push("/PinCode");
          },
          child: const Text("PinCodePage")),
      const SizedBox(height: 8),
      ElevatedButton(
          onPressed: () {
            router.push("/List");
          },
          child: const Text("List Page")),
    ]));
  }
}
