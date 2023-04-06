import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class XxxStorage {
  Future<String?> read(String key) async {
    return Future<String?>.value("true");
  }

  void write(String key, String? value) async {}
}

enum AuthType {
  face,
  pinCode,
}

class XxxRepository {
  XxxStorage storage;

  XxxRepository({required this.storage});

  Future<AuthType> fetch() async {
    print('XxxRepository fetch');

    String? s = await storage.read('test');

    if (s == 'true') {
      return Future<AuthType>.value(AuthType.pinCode);
    }
    return Future<AuthType>.value(AuthType.face);
  }

  void post(AuthType value) async {
    return storage.write('test', (value == AuthType.pinCode).toString());
  }
}

class YyyRepository extends ChangeNotifier {
  late int data;

  static final YyyRepository _instance = YyyRepository._internal();

  factory YyyRepository() {
    return _instance;
  }

  YyyRepository._internal() {
    data = 0;
  }

  void inc() async {
    data++;
    notifyListeners();
  }

  void dec() async {
    data--;
    notifyListeners();
  }

  int getData() {
    return data;
  }

  void test() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    data = 0;
    notifyListeners();
  }
}

final yyyRepositoryProvider = ChangeNotifierProvider<YyyRepository>((ref) {
  return YyyRepository();
});

class YyyRepositoryNotifier extends StateNotifier<int> {
  late final StateNotifierProviderRef _ref;
  YyyRepositoryNotifier(StateNotifierProviderRef ref)
      : _ref = ref,
        super(0) {
    final repo = ref.watch(yyyRepositoryProvider);
    state = repo.data;
  }
}

final yyyRepositoryNotifierProvider =
    StateNotifierProvider<YyyRepositoryNotifier, int>(
  (ref) {
    return YyyRepositoryNotifier(ref);
  },
);
