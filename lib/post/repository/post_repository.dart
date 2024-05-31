import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import '../../secure_storage_service.dart';
import 'dart:io';

class PostRepository {
  final String baseUrl;
  final SecureStorageService _secureStorageService = SecureStorageService();

  PostRepository({required this.baseUrl});

  Future<void> createPost({
    required String category,
    required String description,
    required String location,
    required String time,
    List<int>? pictureBuffer,
  }) async {
    final token = await _secureStorageService.readToken();
    final url = Uri.parse('$baseUrl/items');
    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['category'] = category;
    request.fields['description'] = description;
    request.fields['location'] = location;
    request.fields['time'] = time;

    if (pictureBuffer != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'picture',
        Uint8List.fromList(pictureBuffer),
        filename: 'image.jpg', // Provide a filename here
        // contentType: MediaType('image', 'jpg'),
      ));
    }

    final response = await request.send();
    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
    }
  }

  Future<Map<String, dynamic>> fetchPostDetails(String postId) async {
    final url = Uri.parse('$baseUrl/items/$postId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load post details');
    }
  }

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('http://localhost:3003/items'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
