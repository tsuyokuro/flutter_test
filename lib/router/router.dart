import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../view/list_page.dart';
import '../view/pincode_page.dart';
import '../view/register_device_page.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MyHomePage(),
        ),
        GoRoute(
          path: '/RegisterDevice',
          builder: (context, state) => const RegisterDevicePage(),
        ),
        GoRoute(
          path: '/PinCode',
          builder: (context, state) => const PinCodePage(),
        ),
        GoRoute(
          path: '/List',
          builder: (context, state) => const ListPage(),
        ),
      ],
      redirect: (context, state) {
        return null;
      }),
);
