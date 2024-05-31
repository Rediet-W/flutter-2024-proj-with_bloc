import 'package:http/http.dart' as http;
// import 'package:mongo_dart/mongo_dart.dart';
import 'dart:convert';
import '../../secure_storage_service.dart';

import '../model/comment.dart';

class CommentRepository {
  final String baseUrl;

  CommentRepository({required this.baseUrl});
  final SecureStorageService _secureStorageService = SecureStorageService();

  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Comment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Comment> addComment(Comment comment) async {
    final String? token = await _secureStorageService.readToken();
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode(comment.toJson()),
    );

    if (response.statusCode == 201) {
      return Comment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add comment');
    }
  }

  Future<void> deleteComment(String? commentId) async {
    final String? token = await _secureStorageService.readToken();
    final response = await http
        .delete(Uri.parse('$baseUrl/comments/$commentId'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to delete comment');
    }
  }

  Future<void> editComment(String? commentId, String content) async {
    final String? token = await _secureStorageService.readToken();
    final response = await http.patch(
      Uri.parse('$baseUrl/comments/$commentId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode({'content': content}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit comment');
    }
  }
}
