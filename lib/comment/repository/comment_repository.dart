import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/comment.dart';

class CommentRepository {
  final String baseUrl;

  CommentRepository({required this.baseUrl});

  Future<List<Comment>> fetchComments(String postId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/comments?postId=$postId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Comment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Comment> addComment(Comment comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(comment.toJson()),
    );

    if (response.statusCode == 201) {
      return Comment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
