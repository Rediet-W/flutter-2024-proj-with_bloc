import 'package:flutter_project/comment/model/comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Comment', () {
    test(
        'Comment is created with correct id, postId, userId, content, and timestamp',
        () {
      // Define sample data
      const id = '1';
      const postId = 'post123';
      const userId = 'user456';
      const content = 'This is a test comment';
      final timestamp = DateTime.now();

      // Create a comment object
      final comment = Comment(
        id: id,
        postId: postId,
        userId: userId,
        content: content,
        timestamp: timestamp,
      );

      // Verify the properties of the comment object
      expect(comment.id, equals(id));
      expect(comment.postId, equals(postId));
      expect(comment.userId, equals(userId));
      expect(comment.content, equals(content));
      expect(comment.timestamp, equals(timestamp));
    });

    test('Comment.fromJson converts JSON correctly', () {
      // Define sample JSON data
      final json = {
        'id': '1',
        'postId': 'post123',
        'userId': 'user456',
        'content': 'This is a test comment',
        'timestamp': '2022-05-27T10:00:00Z',
      };

      // Convert JSON to Comment object
      final comment = Comment.fromJson(json);

      // Verify the properties of the comment object
      expect(comment.id, equals(json['id']));
      expect(comment.postId, equals(json['postId']));
      expect(comment.userId, equals(json['userId']));
      expect(comment.content, equals(json['content']));
      expect(comment.timestamp, equals(DateTime.parse(json['timestamp']!)));
    });

    test('toJson returns correct JSON format', () {
      // Define sample comment object
      final comment = Comment(
        id: '1',
        postId: 'post123',
        userId: 'user456',
        content: 'This is a test comment',
        timestamp: DateTime(2022, 5, 27, 10, 0, 0),
      );

      // Convert comment object to JSON
      final json = comment.toJson();

      // Verify the JSON format
      expect(json['id'], equals(comment.id));
      expect(json['postId'], equals(comment.postId));
      expect(json['userId'], equals(comment.userId));
      expect(json['content'], equals(comment.content));
      expect(json['timestamp'], equals(comment.timestamp.toIso8601String()));
    });
  });
}
