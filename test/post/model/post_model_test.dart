import 'dart:typed_data';
import 'package:flutter_project/post/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post', () {
    test(
        'Post is created with correct title, description, location, time, and imageBuffer',
        () {
      // Define sample data
      const title = 'Test Post';
      const description = 'This is a test description';
      const location = 'Test Location';
      const time = 'Test Time';
      final imageBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);

      // Create a post object
      final post = Post(
        title: title,
        description: description,
        location: location,
        time: time,
        imageBuffer: imageBuffer,
      );

      // Verify the properties of the post object
      expect(post.title, equals(title));
      expect(post.description, equals(description));
      expect(post.location, equals(location));
      expect(post.time, equals(time));
      expect(post.imageBuffer, equals(imageBuffer));
    });

    test('Post.fromJson converts JSON correctly', () {
      // Define sample JSON data
      final json = {
        'title': 'Test Post',
        'description': 'This is a test description',
        'location': 'Test Location',
        'time': 'Test Time',
        'picture': {
          'data': [1, 2, 3, 4, 5]
        },
      };

      // Convert JSON to Post object
      final post = Post.fromJson(json);

      // Verify the properties of the post object
      expect(post.title, equals(json['title']));
      expect(post.description, equals(json['description']));
      expect(post.location, equals(json['location']));
      expect(post.time, equals(json['time']));
    });

    test('toJson returns correct JSON format', () {
      // Define sample post object
      final post = Post(
        title: 'Test Post',
        description: 'This is a test description',
        location: 'Test Location',
        time: 'Test Time',
        imageBuffer: Uint8List.fromList([1, 2, 3, 4, 5]),
      );

      // Convert post object to JSON
      final json = post.toJson();

      // Verify the JSON format
      expect(json['title'], equals(post.title));
      expect(json['description'], equals(post.description));
      expect(json['location'], equals(post.location));
      expect(json['time'], equals(post.time));
      expect(json['imageBuffer'], equals(post.imageBuffer));
    });

    test('Equality test for Post objects', () {
      // Define two identical posts
      final post1 = Post(
        title: 'Test Post',
        description: 'This is a test description',
        location: 'Test Location',
        time: 'Test Time',
        imageBuffer: Uint8List.fromList([1, 2, 3, 4, 5]),
      );
      final post2 = Post(
        title: 'Test Post',
        description: 'This is a test description',
        location: 'Test Location',
        time: 'Test Time',
        imageBuffer: Uint8List.fromList([1, 2, 3, 4, 5]),
      );

      // Verify that the two posts are equal
      expect(post1, equals(post2));
    });
  });
}
