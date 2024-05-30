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

    print('Login response status: ${response.statusCode}');
    print('Login response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final roles = List<String>.from(data['roles'] ?? []);
      if (token == null || roles.isEmpty) {
        throw Exception('Token or roles missing in response');
      }
      await _secureStorageService.writeTokenAndRoles(token, roles);

      return User(
        id: data['id'] ?? '', // Provide default values if null
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

    print('Signup response status: ${response.statusCode}');
    print('Signup response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final roles = List<String>.from(data['roles'] ?? []);
      if (token == null || roles.isEmpty) {
        throw Exception('Token or roles missing in response');
      }
      await _secureStorageService.writeTokenAndRoles(token, roles);

      return User(
        id: data['id'] ?? '', // Provide default values if null
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
    final token = await _secureStorageService.readToken();
    if (token == null) {
      throw Exception('No token found, please log in first');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print('Logout response status: ${response.statusCode}');
    print('Logout response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      await _secureStorageService.deleteTokenAndRoles();
    } else {
      throw Exception(
          'Failed to log out: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
