import 'package:flutter_project/auth/model/user.dart';

class AuthRepository {
  // log in
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return User(id: '1', email: email, username: 'testUser');
  }

  Future<User> signup(String username, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return User(id: '2', email: email, username: username);
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
