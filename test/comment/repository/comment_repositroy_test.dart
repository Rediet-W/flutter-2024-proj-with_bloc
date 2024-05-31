import 'package:flutter_project/comment/model/comment.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'comment_repositroy_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CommentRepository commentRepository;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    commentRepository = CommentRepository(
        baseUrl: 'http://10.0.2.2:3003',
        client: mockHttpClient,
        httpClient: http.Client());
  });

  group('fetchComments', () {
    const postId = '123';

    test('returns a list of comments if the http call completes successfully',
        () async {
      final responseJson = [
        {
          'id': '1',
          'postId': postId,
          'userId': 'user1',
          'content': 'This is a comment',
          'timestamp': '2023-05-01T00:00:00.000Z'
        },
      ];

      // Mocking the HTTP client to return a successful response
      when(mockHttpClient
              .get(Uri.parse('http://10.0.2.2:3003/comments?postId=$postId')))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(responseJson), 200));

      // Fetch comments
      final comments = await commentRepository.fetchComments(postId);

      expect(comments, isA<List<Comment>>());
      expect(comments.length, 1);
      expect(comments[0].content, 'This is a comment');
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // Mocking the HTTP client to return an error response
      when(mockHttpClient
              .get(Uri.parse('http://10.0.2.2:3003/comments?postId=$postId')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Expect the fetchComments method to throw an exception
      expect(() async => await commentRepository.fetchComments(postId),
          throwsException);
    });
  });

  group('addComment', () {
    test('returns a comment if the http call completes successfully', () async {
      final newComment = Comment(
        id: '1',
        postId: '123',
        userId: 'user1',
        content: 'This is a new comment',
        timestamp: DateTime.parse('2023-05-01T00:00:00.000Z'),
      );

      final responseJson = {
        'id': '1',
        'postId': '123',
        'userId': 'user1',
        'content': 'This is a new comment',
        'timestamp': '2023-05-01T00:00:00.000Z'
      };

      // Mocking the HTTP client to return a successful response
      when(mockHttpClient.post(
        Uri.parse('http://10.0.2.2:3003/comments'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newComment.toJson()),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseJson), 201));

      // Add a comment
      final comment = await commentRepository.addComment(newComment);

      expect(comment, isA<Comment>());
      expect(comment.content, 'This is a new comment');
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final newComment = Comment(
        id: '1',
        postId: '123',
        userId: 'user1',
        content: 'This is a new comment',
        timestamp: DateTime.parse('2023-05-01T00:00:00.000Z'),
      );

      // Mocking the HTTP client to return an error response
      when(mockHttpClient.post(
        Uri.parse('http://10.0.2.2:3003/comments'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newComment.toJson()),
      )).thenAnswer((_) async => http.Response('Failed to add comment', 400));

      // Expect the addComment method to throw an exception
      expect(() async => await commentRepository.addComment(newComment),
          throwsException);
    });
  });
}
