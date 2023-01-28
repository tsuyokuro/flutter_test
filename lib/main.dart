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
              width: 80,
              child: Text(
                "ID:",
                textAlign: TextAlign.end,
              )),
          const SizedBox(
            width: 16,
          ),
          // Input field
          SizedBox(
            width: 200,
            child: TextField(controller: _userNameController),
          ),
        ],
      ),

      const SizedBox(height: 4),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
              width: 80,
              child: Text(
                "パスワード:",
                textAlign: TextAlign.end,
              )),
          const SizedBox(
            width: 16,
          ),
          // Input field
          SizedBox(
            width: 200,
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

      const SizedBox(height: 8),

      Consumer(
        builder: (context, ref, child) {
          String s = ref.watch(pinCodeProvider);
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
        var notifier = ref.read(pinCodeProvider.notifier);
        return TenKey(pinCodeNotifier: notifier);
      })),
    ]));
  }
}

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
