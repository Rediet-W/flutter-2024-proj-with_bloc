import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:flutter_project/comment/model/comment.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';
import 'package:flutter_project/secure_storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'comment_repository_test.mocks.dart';

// Generate mocks for the SecureStorageService
@GenerateMocks([SecureStorageService])
void main() {
  late CommentRepository commentRepository;
  late MockSecureStorageService mockSecureStorageService;
  late http.Client mockClient; // Declare the mock client here

  setUp(() {
    mockSecureStorageService = MockSecureStorageService();

    // Initialize MockClient
    mockClient = MockClient((request) async {
      if (request.method == 'GET' && request.url.path == '/comments') {
        return http.Response(
            jsonEncode([
              {"id": "1", "userId": "user1", "content": "Comment 1"},
              {"id": "2", "userId": "user2", "content": "Comment 2"}
            ]),
            200);
      } else if (request.method == 'POST' && request.url.path == '/comments') {
        final body = jsonDecode(request.body);
        return http.Response(
            jsonEncode({
              "id": "1",
              "userId": body['userId'],
              "content": body['content']
            }),
            201);
      } else if (request.method == 'DELETE' &&
          request.url.path.startsWith('/comments/')) {
        return http.Response('', 200);
      } else if (request.method == 'PATCH' &&
          request.url.path.startsWith('/comments/')) {
        final body = jsonDecode(request.body);
        return http.Response(jsonEncode({"content": body['content']}), 200);
      }
      return http.Response('Not Found', 404);
    });

    // Use the mockClient directly in the repository creation
    commentRepository = CommentRepository(baseUrl: 'http://localhost:3003');
  });

  test(
      'fetchComments returns a list of comments if the http call completes successfully',
      () async {
    List<Comment> comments = await commentRepository.fetchComments();
    expect(comments.length, 2);
    expect(comments[0].content, 'Comment 1');
    expect(comments[1].content, 'Comment 2');
  });

  test('addComment returns a Comment if the http call completes successfully',
      () async {
    when(mockSecureStorageService.readToken())
        .thenAnswer((_) async => 'mock_token');

    final comment = Comment(userId: 'user1', content: 'New Comment');
    final addedComment = await commentRepository.addComment(comment);
    expect(addedComment.id, "1");
    expect(addedComment.content, "New Comment");
  });

  test('deleteComment succeeds if the http call completes successfully',
      () async {
    when(mockSecureStorageService.readToken())
        .thenAnswer((_) async => 'mock_token');

    expect(commentRepository.deleteComment('1'), completes);
  });

  test('editComment succeeds if the http call completes successfully',
      () async {
    when(mockSecureStorageService.readToken())
        .thenAnswer((_) async => 'mock_token');

    expect(commentRepository.editComment('1', 'Updated Comment'), completes);
  });
}
