import 'dart:convert';
import 'package:http/http.dart' as http;

class PostRepository {
  final String baseUrl;

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
}
