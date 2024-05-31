import 'package:mongo_dart/mongo_dart.dart';

class Comment {
  final String postId;
  final String userId;
  final String content;

  Comment({required this.postId, required this.userId, required this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      userId: json['userId'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'content': content,
    };
  }
}
