import 'dart:typed_data';
import 'package:flutter_project/post/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post', () {
    test(
        'Post is created with correct id, location, description, and pictureBuffer',
        () {
      // Define sample data
      const id = '1';
      const location = 'Test Location';
      const description = 'This is a test description';
      final pictureBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);

      // Create a post object
      final post = Post(
        id: id,
        location: location,
        description: description,
        pictureBuffer: pictureBuffer,
      );

      // Verify the properties of the post object
      expect(post.id, equals(id));
      expect(post.location, equals(location));
      expect(post.description, equals(description));
      expect(post.pictureBuffer, equals(pictureBuffer));
    });

    test('Post.fromJson converts JSON correctly', () {
      // Define sample JSON data
      final json = {
        'id': '1',
        'location': 'Test Location',
        'description': 'This is a test description',
        'picture': 'AQIDBAU=' // base64 for [1, 2, 3, 4, 5]
      };

      // Convert JSON to Post object
      final post = Post.fromJson(json);

      // Verify the properties of the post object
      expect(post.id, equals(json['id']));
      expect(post.location, equals(json['location']));
      expect(post.description, equals(json['description']));
      expect(post.pictureBuffer, equals(Uint8List.fromList([1, 2, 3, 4, 5])));
    });

    test('toJson returns correct JSON format', () {
      // Define sample post object
      final post = Post(
        id: '1',
        location: 'Test Location',
        description: 'This is a test description',
        pictureBuffer: Uint8List.fromList([1, 2, 3, 4, 5]),
      );

      // Convert post object to JSON
      final json = post.toJson();

      // Verify the JSON format
      expect(json['id'], equals(post.id));
      expect(json['location'], equals(post.location));
      expect(json['description'], equals(post.description));
      expect(json['picture'], equals('AQIDBAU=')); // base64 for [1, 2, 3, 4, 5]
    });

    test('Equality test for Post objects', () {
      // Define two identical posts
      final post1 = Post(
        id: '1',
        location: 'Test Location',
        description: 'This is a test description',
        pictureBuffer: Uint8List.fromList([1, 2, 3, 4, 5]),
      );
      final post2 = Post(
        id: '1',
        location: 'Test Location',
        description: 'This is a test description',
        pictureBuffer: Uint8List.fromList([1, 2, 3, 4, 5]),
      );

      // Verify that the two posts are equal
      expect(post1, equals(post2));
    });
  });
}
