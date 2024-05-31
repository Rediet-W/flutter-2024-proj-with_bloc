import 'package:flutter_project/auth/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('User is created with correct id, email, and username', () {
      const id = '1';
      const email = 'test@example.com';
      const username = 'testUser';

      final user = User(id: id, email: email, username: username, roles: []);

      expect(user.id, equals(id));
      expect(user.email, equals(email));
      expect(user.username, equals(username));
    });
  });
}
