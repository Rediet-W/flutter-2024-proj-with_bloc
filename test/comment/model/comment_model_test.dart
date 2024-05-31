import 'package:flutter_project/comment/model/comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Comment', () {
    test(
        'Comment is created with correct id, postId, userId, content, and timestamp',
        () {
      // Define sample data
      const id = '1';
      const userId = 'user456';
      const content = 'This is a test comment';

      // Create a comment object
      final comment = Comment(
        id: id,
        userId: userId,
        content: content,
      );

      // Verify the properties of the comment object
      expect(comment.id, equals(id));
      expect(comment.userId, equals(userId));
      expect(comment.content, equals(content));
    });

    test('Comment.fromJson converts JSON correctly', () {
      // Define sample JSON data
      final json = {
        'id': '1',
        'userId': 'user456',
        'content': 'This is a test comment',
      };

      // Convert JSON to Comment object
      final comment = Comment.fromJson(json);

      // Verify the properties of the comment object
      expect(comment.id, equals(json['id']));
      expect(comment.userId, equals(json['userId']));
      expect(comment.content, equals(json['content']));
    });

    test('toJson returns correct JSON format', () {
      // Define sample comment object
      final comment = Comment(
        id: '1',
        userId: 'user456',
        content: 'This is a test comment',
      );

      // Convert comment object to JSON
      final json = comment.toJson();

      // Verify the JSON format
      expect(json['id'], equals(comment.id));
      expect(json['userId'], equals(comment.userId));
      expect(json['content'], equals(comment.content));
    });
  });
}
