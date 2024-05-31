import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/comment.dart';
import 'package:mongo_dart/mongo_dart.dart';

class CommentRepository {
  final String baseUrl;

  CommentRepository({required this.baseUrl});

  Future<List<Comment>> fetchComments(String postId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/comments?postId=$postId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Comment> addComment(Comment comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode == 201) {
      return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
