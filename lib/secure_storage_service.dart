import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> writeTokenAndRoles(String token, List<String> roles) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'roles', value: roles.join(','));
  }

  Future<String?> readToken() async {
    return await _storage.read(key: 'token');
  }

  Future<List<String>?> readRoles() async {
    final roles = await _storage.read(key: 'roles');
    return roles?.split(',');
  }

  Future<void> deleteTokenAndRoles() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'roles');
  }
}
