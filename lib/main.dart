import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view_model/pincode_notifier.dart';
import 'ui_component/ten_key.dart';
import "view/pincode_page.dart";

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

final pinCodeNotifierProvider =
    StateNotifierProvider<PinCodeNotifier, String>((ref) {
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

      ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PinCodePage()));
          },
          child: const Text("PinCodePage")),

      const SizedBox(height: 8),

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
    ]));
  }
}
