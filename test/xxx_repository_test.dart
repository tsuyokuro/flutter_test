import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myapp2/view_model/my_provider.dart';

class MockStorage extends Mock implements XxxStorage {}

void main() {
  late XxxStorage storage;

  test('', () async {
    storage = MockStorage();
    when(() => storage.read('test')).thenAnswer((_) {
      return Future<String>.value('false');
    });

    final repo = XxxRepository(storage: storage);

    AuthType authType = await repo.fetch();

    expect(authType, AuthType.face);
  });

  test('', () async {
    String? w;

    storage = MockStorage();
    when(() => storage.write('test', any())).thenAnswer((invocation) {
      w = invocation.positionalArguments[1];
    });

    final repo = XxxRepository(storage: storage);

    repo.post(AuthType.face);

    String? s = w;

    expect(s, 'false');
  });
}
