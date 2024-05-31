import 'dart:convert';
import 'package:flutter_project/post/model/post.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late PostRepository postRepository;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    postRepository = PostRepository(
        baseUrl: 'http://localhost:3003',
        client: mockHttpClient,
        httpClient: http.Client());
  });

  tearDown(() {
    reset(mockHttpClient);
  });

  group('PostRepository', () {
    group('createPost', () {
      const String testTitle = 'Test Title';
      const String testDescription = 'Test Description';
      const String testLocation = 'Test Location';
      const String testTime = 'Test Time';

      test('createPost - success', () async {
        when(() => mockHttpClient.post(
              any(),
              headers: any(named: 'headers'),
              body: any(named: 'body'),
            )).thenAnswer((_) async => http.Response('', 201));

        await postRepository.createPost(
          title: testTitle,
          description: testDescription,
          location: testLocation,
          time: testTime,
        );

        verify(() => mockHttpClient.post(
              Uri.parse('http://localhost:3003/items'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'title': testTitle,
                'description': testDescription,
                'location': testLocation,
                'time': testTime,
              }),
            )).called(1);
      });

      test('createPost - failure', () async {
        when(() => mockHttpClient.post(
              any(),
              headers: any(named: 'headers'),
              body: any(named: 'body'),
            )).thenAnswer((_) async => http.Response('', 400));

        expect(
          () => postRepository.createPost(
            title: testTitle,
            description: testDescription,
            location: testLocation,
            time: testTime,
          ),
          throwsA(isA<Exception>()),
        );

        verify(() => mockHttpClient.post(
              Uri.parse('http://localhost:3003/items'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'title': testTitle,
                'description': testDescription,
                'location': testLocation,
                'time': testTime,
              }),
            )).called(1);
      });
    });

    group('fetchPostDetails', () {
      const String testPostId = '1';
      final Map<String, dynamic> testPostDetails = {
        'title': 'Test Title',
        'description': 'Test Description',
        'location': 'Test Location',
        'time': 'Test Time',
      };

      test('fetchPostDetails - success', () async {
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode(testPostDetails), 200),
        );

        final result = await postRepository.fetchPostDetails(testPostId);

        expect(result, testPostDetails);
        verify(() => mockHttpClient.get(
            Uri.parse('http://localhost:3003/items/$testPostId'))).called(1);
      });

      test('fetchPostDetails - failure', () async {
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response('', 404),
        );

        expect(
          () => postRepository.fetchPostDetails(testPostId),
          throwsA(isA<Exception>()),
        );

        verify(() => mockHttpClient.get(
            Uri.parse('http://localhost:3003/items/$testPostId'))).called(1);
      });
    });
    group('fetchPosts', () {
      final List<Map<String, dynamic>> testPostsJson = [
        {
          'title': 'Test Title 1',
          'description': 'Test Description 1',
          'location': 'Test Location 1',
          'time': 'Test Time 1',
        },
        {
          'title': 'Test Title 2',
          'description': 'Test Description 2',
          'location': 'Test Location 2',
          'time': 'Test Time 2',
        },
      ];

      final List<Post> testPosts =
          testPostsJson.map((json) => Post.fromJson(json)).toList();

      test('fetchPosts - success', () async {
        when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
            .thenAnswer(
          (_) async => http.Response(jsonEncode(testPostsJson), 200),
        );

        final result = await postRepository.fetchPosts();

        expect(result, testPosts);
        verify(() => mockHttpClient.get(
              Uri.parse('http://localhost:3003/items'),
              headers: {'Content-Type': 'application/json'},
            )).called(1);
      });

      test('fetchPosts - failure', () async {
        when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
            .thenAnswer(
          (_) async => http.Response('', 500),
        );

        expect(
          () => postRepository.fetchPosts(),
          throwsA(isA<Exception>()),
        );

        verify(() => mockHttpClient.get(
              Uri.parse('http://localhost:3003/items'),
              headers: {'Content-Type': 'application/json'},
            )).called(1);
      });
    });
  });
}
