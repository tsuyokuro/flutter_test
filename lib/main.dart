import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class UserInfo {
  final bool isLogin;
  final String userName;

  UserInfo({required this.userName, required this.isLogin});

  UserInfo copyWith({String? userName, bool? isLogin}) {
    return UserInfo(
        userName: userName ?? this.userName, isLogin: isLogin ?? this.isLogin);
  }
}

class UserInfoNotifier extends StateNotifier<UserInfo> {
  UserInfoNotifier() : super(UserInfo(userName: "", isLogin: false));

  void newState(UserInfo userInfo) {
    state = userInfo;
  }
}

final userInfoProvider =
    StateNotifierProvider<UserInfoNotifier, UserInfo>((ref) {
  return UserInfoNotifier();
});

// PIN Code
class PinCodeNotifier extends StateNotifier<String> {
  PinCodeNotifier() : super("");

  void newState(String s) {
    state = s;
  }

  String getState() => state;
}

final pinCodeProvider = StateNotifierProvider<PinCodeNotifier, String>((ref) {
  return PinCodeNotifier();
});

// APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
      body: MyBody(),
    );
  }
}

class MyBody extends StatelessWidget {
  MyBody({super.key});

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      const SizedBox(
        height: 20,
      ),

      Consumer(builder: (context, ref, _) {
        debugPrint("buid text");
        final userInfo = ref.watch(userInfoProvider);
        return Text(userInfo.userName);
      }),

      const SizedBox(
        height: 16,
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
              width: 100,
              child: Text(
                "User name:",
                textAlign: TextAlign.end,
              )),
          const SizedBox(
            width: 16,
          ),
          // Input field
          SizedBox(
            width: 400,
            child: TextField(controller: _userNameController),
          ),
        ],
      ),

      const SizedBox(height: 4),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
              width: 100,
              child: Text(
                "pass:",
                textAlign: TextAlign.end,
              )),
          const SizedBox(
            width: 16,
          ),
          // Input field
          SizedBox(
            width: 400,
            child: TextFormField(controller: _passwordController),
          ),
        ],
      ),

      const SizedBox(height: 8),

      //
      Consumer(builder: ((context, ref, child) {
        final userInfo = ref.read(userInfoProvider);
        var notifier = ref.read(userInfoProvider.notifier);

        debugPrint("buid Button");

        return ElevatedButton(
          child: const Text("Test"),
          onPressed: () {
            notifier.newState(
                userInfo.copyWith(userName: _userNameController.text));
          },
        );
      })),

      Consumer(
        builder: (context, ref, child) {
          String s = ref.watch(pinCodeProvider);
          return Text(s);
        },
      ),

      Consumer(builder: ((context, ref, _) {
        var notifier = ref.read(pinCodeProvider.notifier);
        return TenKey(pinCodeNotifier: notifier);
      })),
    ]));
  }
}

class TenKey extends StatelessWidget {
  final List<int> keys = <int>[];
  final PinCodeNotifier pinCodeNotifier;

  TenKey({super.key, bool random = false, required this.pinCodeNotifier}) {
    keys.clear();
    for (int i = 1; i <= 10; i++) {
      keys.add(i % 10);
    }

    if (random) {}
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cc = <Widget>[];

    for (int y = 0; y < 4; y++) {
      List<Widget> rc = <Widget>[];

      int e = (y == 3) ? 1 : 3;

      for (int x = 0; x < e; x++) {
        int idx = y * 3 + x;

        rc.add(ElevatedButton(
            onPressed: () {
              String s = pinCodeNotifier.getState();
              if (s.length < 4) {
                pinCodeNotifier.newState("$s${keys[idx]}");
              }
            },
            child: Text("${keys[idx]}")));
      }

      cc.add(Row(
        children: rc,
      ));
    }

    return Column(
      children: cc,
    );
  }
}
