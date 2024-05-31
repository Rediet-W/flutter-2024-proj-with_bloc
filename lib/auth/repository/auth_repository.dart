import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import '../../secure_storage_service.dart';

class AuthRepository {
  final String baseUrl = 'http://localhost:3003/auth';
  final SecureStorageService _secureStorageService = SecureStorageService();

  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final roles = List<String>.from(data['roles'] ?? []);
      final userId = data['id']; // Assuming the response contains userId
      if (token == null || roles.isEmpty || userId == null) {
        throw Exception('Token, roles, or userId missing in response');
      }
      await _secureStorageService.writeTokenRolesAndUserId(
          token, roles, userId);

      return User(
        id: userId,
        email: data['email'] ?? '',
        username: data['username'] ?? '',
        roles: roles,
      );
    } else {
      throw Exception(
          'Failed to log in: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<User> signup(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final roles = List<String>.from(data['roles'] ?? []);
      final userId = data['id']; // Assuming the response contains userId
      if (token == null || roles.isEmpty || userId == null) {
        throw Exception('Token, roles, or userId missing in response');
      }
      await _secureStorageService.writeTokenRolesAndUserId(
          token, roles, userId);

      return User(
        id: userId,
        email: data['email'] ?? '',
        username: data['username'] ?? '',
        roles: roles,
      );
    } else {
      throw Exception(
          'Failed to sign up: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> logout() async {
    await _secureStorageService.deleteTokenRolesAndUserId();
  }
}
