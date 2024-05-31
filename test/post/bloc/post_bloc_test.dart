import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_project/post/bloc/post_bloc.dart';
import 'package:flutter_project/post/bloc/post_event.dart';
import 'package:flutter_project/post/bloc/post_state.dart';
import 'package:flutter_project/post/model/post.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_bloc_test.mocks.dart';

// Generate mock classes using Mockito
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
      const String testTitle = 'Test Title';
      const String testDescription = 'Test Description';
      const String testLocation = 'Test Location';
      const String testTime = 'Test Time';

      blocTest<PostBloc, PostState>(
        'emits [PostLoading, PostSuccess] when creating a post is successful',
        build: () {
          when(mockPostRepository.createPost(
            title: testTitle,
            description: testDescription,
            location: testLocation,
            time: testTime,
          )).thenAnswer((_) async => Future.value());
          return postBloc;
        },
        act: (bloc) => bloc.add(CreatePost(
          title: testTitle,
          description: testDescription,
          location: testLocation,
          time: testTime,
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
            title: testTitle,
            description: testDescription,
            location: testLocation,
            time: testTime,
          )).thenThrow(Exception('Failed to create post'));
          return postBloc;
        },
        act: (bloc) => bloc.add(CreatePost(
          title: testTitle,
          description: testDescription,
          location: testLocation,
          time: testTime,
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
          title: 'Test Post 1',
          description: 'Description 1',
          location: 'Location 1',
          time: 'Time 1',
        ),
        Post(
          title: 'Test Post 2',
          description: 'Description 2',
          location: 'Location 2',
          time: 'Time 2',
        ),
      ];

      blocTest<PostBloc, PostState>(
        'emits [PostLoading, PostLoaded] when posts are loaded successfully',
        build: () {
          when(mockPostRepository.fetchPosts())
              .thenAnswer((_) async => testPosts);
          return postBloc;
        },
        act: (bloc) => bloc.add(LoadPost('postId')),
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
        act: (bloc) => bloc.add(LoadPost('postId')),
        expect: () => [
          PostLoading(),
          PostLoadingDetailsError(error: 'Exception: Failed to load posts'),
        ],
      );
    });
  });
}
