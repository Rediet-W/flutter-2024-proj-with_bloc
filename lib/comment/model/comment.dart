class Comment {
  final String? id;
  final String? userId;
  final String content;

  Comment({this.id, required this.userId, required this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'userId': userId,
      'content': content,
    };
  }
}
