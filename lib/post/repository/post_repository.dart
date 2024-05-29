import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import '../../secure_storage_service.dart';

class PostRepository {
  final String baseUrl;

  final SecureStorageService _secureStorageService = SecureStorageService();

  PostRepository({required this.baseUrl});

  Future<void> createPost({
    required String title,
    required String description,
    required String location,
    required String time,
  }) async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'description': description,
        'location': location,
        'time': time,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
    }
  }

  Future<Map<String, dynamic>> fetchPostDetails(String postId) async {
    final url = Uri.parse('$baseUrl/posts/$postId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load post details');
    }
  }

  Future<List<Post>> fetchItems() async {
    final token = await _secureStorageService.readToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
