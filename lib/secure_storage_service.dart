import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> writeTokenRolesAndUserId(
      String token, List<String> roles, String userId) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'roles', value: roles.join(','));
    await _storage.write(key: 'userId', value: userId);
  }

  Future<String?> readToken() async {
    return await _storage.read(key: 'token');
  }

  Future<List<String>?> readRoles() async {
    final roles = await _storage.read(key: 'roles');
    return roles?.split(',');
  }

  Future<String?> readUserId() async {
    return await _storage.read(key: 'userId');
  }

  Future<void> deleteTokenRolesAndUserId() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'roles');
    await _storage.delete(key: 'userId');
  }
}
