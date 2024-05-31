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
      final userId = data['id'];
      if (token == null || roles.isEmpty || userId == null) {
        throw Exception('Token, roles, or userId missing in response');
      }
      await _secureStorageService.writeTokenRolesAndUserId(
          token, roles, userId);

      return User(
        id: userId,
        email: data['email'] ?? '',
        fullname: data['fullname'] ?? '',
        roles: roles,
      );
    } else {
      throw Exception(
          'Failed to log in: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<User> signup(
    String username,
    String email,
    String password,
  ) async {
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
      final userId = data['id'];
      if (token == null || roles.isEmpty || userId == null) {
        throw Exception('Token, roles, or userId missing in response');
      }
      await _secureStorageService.writeTokenRolesAndUserId(
          token, roles, userId);

      return User(
        id: userId,
        email: data['email'] ?? '',
        fullname: data['fullname'] ?? '',
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

  Future<User> getUserProfile(String? userId) async {
    final token = await _secureStorageService.readToken();
    final response = await http.get(
      Uri.parse('http://localhost:3003/users/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception(
          'Failed to load profile: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<User> updateUserProfile(String? userId, String password) async {
    final response = await http.patch(
      Uri.parse('http://localhost:3003/users/$userId/password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await _secureStorageService.readToken()}',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception(
          'Failed to update user profile: ${response.reasonPhrase}');
    }
  }

  Future<void> deleteUserProfile(String? userId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3003/users/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await _secureStorageService.readToken()}',
      },
    );

    if (response.statusCode != 204) {
      throw Exception(
          'Failed to delete user profile: ${response.reasonPhrase}');
    }
  }
}
