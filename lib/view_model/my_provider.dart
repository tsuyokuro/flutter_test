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
