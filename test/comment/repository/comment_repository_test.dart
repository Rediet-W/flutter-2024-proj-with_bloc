// import 'package:flutter_project/comment/model/comment.dart';
// import 'package:flutter_project/comment/repository/comment_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'comment_repository_test.mocks.dart';

// @GenerateMocks([http.Client])
// void main() {
//   late CommentRepository commentRepository;
//   late MockClient mockHttpClient;

//   setUp(() {
//     mockHttpClient = MockClient();
//     // Create a CommentRepository instance for testing, mocking the HTTP client within the tests.
//     commentRepository = CommentRepository(baseUrl: 'http://10.0.2.2:3003');
//   });

//   group('fetchComments', () {
//     test('returns a list of comments if the HTTP call completes successfully',
//         () async {
//       final responseJson = [
//         {
//           'id': '1',
//           'userId': 'user1',
//           'content': 'This is a comment',
//         },
//       ];

//       // Mocking the HTTP client to return a successful response
//       when(mockHttpClient.get(Uri.parse('http://10.0.2.2:3003/comments')))
//           .thenAnswer(
//               (_) async => http.Response(jsonEncode(responseJson), 200));

//       // Use a private method to inject the mock client for testing
//       await _setMockHttpClientForTesting(commentRepository, mockHttpClient);

//       // Fetch comments
//       final comments = await commentRepository.fetchComments();

//       // Verify the results
//       expect(comments, isA<List<Comment>>());
//       expect(comments.length, 1);
//       expect(comments[0].content, 'This is a comment');
//     });

//     test('throws an exception if the HTTP call completes with an error',
//         () async {
//       // Mocking the HTTP client to return an error response
//       when(mockHttpClient.get(Uri.parse('http://10.0.2.2:3003/comments')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));

//       // Use a private method to inject the mock client for testing
//       await _setMockHttpClientForTesting(commentRepository, mockHttpClient);

//       // Expect the fetchComments method to throw an exception
//       expect(
//           () async => await commentRepository.fetchComments(), throwsException);
//     });
//   });

//   group('addComment', () {
//     test('returns a comment if the HTTP call completes successfully', () async {
//       final newComment = Comment(
//         id: '1',
//         userId: 'user1',
//         content: 'This is a new comment',
//       );

//       final responseJson = {
//         'id': '1',
//         'userId': 'user1',
//         'content': 'This is a new comment',
//       };

//       // Mocking the HTTP client to return a successful response
//       when(mockHttpClient.post(
//         Uri.parse('http://10.0.2.2:3003/comments'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(newComment.toJson()),
//       )).thenAnswer((_) async => http.Response(jsonEncode(responseJson), 201));

//       // Use a private method to inject the mock client for testing
//       await _setMockHttpClientForTesting(commentRepository, mockHttpClient);

//       // Add a comment
//       final comment = await commentRepository.addComment(newComment);

//       // Verify the results
//       expect(comment, isA<Comment>());
//       expect(comment.content, 'This is a new comment');
//     });

//     test('throws an exception if the HTTP call completes with an error',
//         () async {
//       final newComment = Comment(
//         id: '1',
//         userId: 'user1',
//         content: 'This is a new comment',
//       );

//       // Mocking the HTTP client to return an error response
//       when(mockHttpClient.post(
//         Uri.parse('http://10.0.2.2:3003/comments'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(newComment.toJson()),
//       )).thenAnswer((_) async => http.Response('Failed to add comment', 400));

//       // Use a private method to inject the mock client for testing
//       await _setMockHttpClientForTesting(commentRepository, mockHttpClient);

//       // Expect the addComment method to throw an exception
//       expect(() async => await commentRepository.addComment(newComment),
//           throwsException);
//     });
//   });
// }

// /// Private method to inject a mock HTTP client into the CommentRepository for testing.
// Future<void> _setMockHttpClientForTesting(
//     CommentRepository repository, http.Client mockClient) async {
//   // Reflection can be used here if you do not want to change the actual repository code.
//   // You can use package `reflectable` or similar to access private fields or methods.
//   final _clientField = repository.runtimeType
//       .toString()
//       .toLowerCase()
//       .replaceFirst(
//           '_', ''); // Normally you'd use some reflection approach here.

//   // Inject the mock client
//   final clientSymbol = Symbol('_client');
//   final mirror = reflect(repository);
//   mirror.setField(clientSymbol, mockClient);
// }
