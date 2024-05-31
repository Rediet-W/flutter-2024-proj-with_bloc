import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_project/post/bloc/post_bloc.dart';
import 'package:flutter_project/post/bloc/post_event.dart';
import 'package:flutter_project/post/bloc/post_state.dart';
import 'package:flutter_project/post/model/post.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:typed_data';

import 'post_bloc_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  group('PostBloc', () {
    late MockPostRepository mockPostRepository;
    late PostBloc postBloc;

    setUp(() {
      mockPostRepository = MockPostRepository();
      postBloc = PostBloc(postRepository: mockPostRepository);
    });

    tearDown(() {
      postBloc.close();
    });

    group('CreatePost', () {
      const String testCategory = 'Test Category';
      const String testDescription = 'Test Description';
      const String testLocation = 'Test Location';
      const String testTime = 'Test Time';
      final Uint8List testPictureBuffer = Uint8List.fromList([0, 1, 2]);

      blocTest<PostBloc, PostState>(
        'emits [PostLoading, PostSuccess] when creating a post is successful',
        build: () {
          when(mockPostRepository.createPost(
            category: testCategory,
            description: testDescription,
            location: testLocation,
            time: testTime,
            pictureBuffer: testPictureBuffer,
          )).thenAnswer((_) async => Future.value());
          return postBloc;
        },
        act: (bloc) => bloc.add(CreatePost(
          category: testCategory,
          description: testDescription,
          location: testLocation,
          time: testTime,
          pictureBuffer: testPictureBuffer,
        )),
        expect: () => [
          PostLoading(),
          PostSuccess(),
        ],
      );

      blocTest<PostBloc, PostState>(
        'emits [PostLoading, PostFailure] when creating a post fails',
        build: () {
          when(mockPostRepository.createPost(
            category: testCategory,
            description: testDescription,
            location: testLocation,
            time: testTime,
            pictureBuffer: testPictureBuffer,
          )).thenThrow(Exception('Failed to create post'));
          return postBloc;
        },
        act: (bloc) => bloc.add(CreatePost(
          category: testCategory,
          description: testDescription,
          location: testLocation,
          time: testTime,
          pictureBuffer: testPictureBuffer,
        )),
        expect: () => [
          PostLoading(),
          PostFailure(error: 'Exception: Failed to create post'),
        ],
      );
    });

    group('LoadPost', () {
      final List<Post> testPosts = [
        Post(
          id: '1',
          location: 'Location 1',
          description: 'Description 1',
          pictureBuffer: Uint8List.fromList([0, 1]),
        ),
        Post(
          id: '2',
          location: 'Location 2',
          description: 'Description 2',
          pictureBuffer: Uint8List.fromList([2, 3]),
        ),
      ];

      blocTest<PostBloc, PostState>(
        'emits [PostLoading, PostLoaded] when posts are loaded successfully',
        build: () {
          when(mockPostRepository.fetchPosts())
              .thenAnswer((_) async => testPosts);
          return postBloc;
        },
        act: (bloc) => bloc.add(LoadPost('')),
        expect: () => [
          PostLoading(),
          PostLoaded(testPosts),
        ],
      );

      blocTest<PostBloc, PostState>(
        'emits [PostLoading, PostLoadingDetailsError] when loading posts fails',
        build: () {
          when(mockPostRepository.fetchPosts())
              .thenThrow(Exception('Failed to load posts'));
          return postBloc;
        },
        act: (bloc) => bloc.add(LoadPost('')),
        expect: () => [
          PostLoading(),
          PostLoadingDetailsError(error: 'Exception: Failed to load posts'),
        ],
      );
    });
  });
}
