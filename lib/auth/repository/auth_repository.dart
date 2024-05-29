import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_project/auth/model/user.dart';
import '../../secure_storage_service.dart'; // Make sure to import the SecureStorageService

class AuthRepository {
  final String baseUrl = 'http://localhost:3003/auth';
  final SecureStorageService _secureStorageService = SecureStorageService();

  // log in
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _secureStorageService.writeToken(data['token']);
      return User(
          id: data['id'], email: data['email'], username: data['username']);
    } else {
      throw Exception('Failed to log in');
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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _secureStorageService.writeToken(data['token']);
      return User(
          id: data['id'], email: data['email'], username: data['username']);
    } else {
      throw Exception('Failed to sign up');
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

    if (response.statusCode == 200) {
      await _secureStorageService.deleteToken();
    } else {
      throw Exception('Failed to log out');
    }
  }

  // Method to get headers with token
  Future<Map<String, String>> _getHeaders() async {
    final token = await _secureStorageService.readToken();
    if (token == null) {
      throw Exception('No token found, please log in first');
    }
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  // Example of another authenticated request
  Future<User> getUserDetails() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/details'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User(
          id: data['id'], email: data['email'], username: data['username']);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }
}
