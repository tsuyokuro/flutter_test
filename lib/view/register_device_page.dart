import 'package:flutter/material.dart';

class RegisterDevicePage extends StatelessWidget {
  const RegisterDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("端末登録"),
      ),
      body: Center(child: RegisterDevicePageBody()),
    );
  }
}

class RegisterDevicePageBody extends StatelessWidget {
  final _medicInstitutionController = TextEditingController();
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _actCodeController = TextEditingController();

  static const double labelW = 130;
  static const double inputW = 200;
  static const double space = 16;

  RegisterDevicePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                width: labelW,
                child: Text(
                  "医療機関コード:",
                  textAlign: TextAlign.end,
                )),
            const SizedBox(
              width: space,
            ),
            // Input field
            SizedBox(
              width: inputW,
              child: TextField(controller: _medicInstitutionController),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                width: labelW,
                child: Text(
                  "ID:",
                  textAlign: TextAlign.end,
                )),
            const SizedBox(
              width: space,
            ),
            // Input field
            SizedBox(
              width: inputW,
              child: TextField(controller: _userIdController),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                width: labelW,
                child: Text(
                  "パスワード:",
                  textAlign: TextAlign.end,
                )),
            const SizedBox(
              width: space,
            ),
            // Input field
            SizedBox(
              width: inputW,
              child: TextFormField(controller: _passwordController),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                width: labelW,
                child: Text(
                  "アクティベーションコード:",
                  textAlign: TextAlign.end,
                )),
            const SizedBox(
              width: space,
            ),
            // Input field
            SizedBox(
              width: inputW,
              child: TextFormField(controller: _actCodeController),
            ),
          ],
        ),
      ],
    );
  }
}
