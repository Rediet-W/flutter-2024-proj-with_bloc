import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_project/comment/bloc/comment_bloc.dart';
import 'package:flutter_project/comment/bloc/comment_event.dart';
import 'package:flutter_project/comment/bloc/comment_state.dart';
import 'package:flutter_project/comment/model/comment.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'comment_bloc_test.mocks.dart';

// Generate mock classes using Mockito
@GenerateMocks([CommentRepository])
void main() {
  group('CommentBloc', () {
    late MockCommentRepository mockCommentRepository;
    late CommentBloc commentBloc;

    setUp(() {
      mockCommentRepository = MockCommentRepository();
      commentBloc = CommentBloc(commentRepository: mockCommentRepository);
    });

    tearDown(() {
      commentBloc.close();
    });

    group('LoadComments', () {
      const String testPostId = 'postId123';
      final List<Comment> testComments = [
        Comment(
            id: '1',
            postId: testPostId,
            userId: 'user1',
            content: 'Comment 1',
            timestamp: DateTime.now()),
        Comment(
            id: '2',
            postId: testPostId,
            userId: 'user2',
            content: 'Comment 2',
            timestamp: DateTime.now()),
      ];

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentsLoaded] when comments are loaded successfully',
        build: () {
          when(mockCommentRepository.fetchComments(testPostId))
              .thenAnswer((_) async => testComments);
          return commentBloc;
        },
        act: (bloc) => bloc.add(LoadComments(testPostId)),
        expect: () => [
          CommentsLoading(),
          CommentsLoaded(testComments),
        ],
        verify: (_) {
          verify(mockCommentRepository.fetchComments(testPostId)).called(1);
        },
      );

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentError] when loading comments fails',
        build: () {
          when(mockCommentRepository.fetchComments(testPostId))
              .thenThrow(Exception('Failed to load comments'));
          return commentBloc;
        },
        act: (bloc) => bloc.add(LoadComments(testPostId)),
        expect: () => [
          CommentsLoading(),
          CommentError('Failed to load comments'),
        ],
      );
    });

    group('AddComment', () {
      const String testPostId = 'postId123';
      const String testUserId = 'userId123';
      const String testContent = 'This is a comment';
      final Comment testComment = Comment(
        id: '1',
        postId: testPostId,
        userId: testUserId,
        content: testContent,
        timestamp: DateTime.now(),
      );

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentsLoaded] with the new comment added when adding a comment is successful',
        build: () {
          when(mockCommentRepository.addComment(any))
              .thenAnswer((_) async => testComment);
          when(mockCommentRepository.fetchComments(testPostId))
              .thenAnswer((_) async => [testComment]);
          return commentBloc;
        },
        act: (bloc) => bloc.add(AddComment(
            postId: testPostId, userId: testUserId, content: testContent)),
        expect: () => [
          CommentsLoading(),
          CommentsLoaded([testComment]),
        ],
        verify: (_) {
          verify(mockCommentRepository.addComment(any)).called(1);
        },
      );

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentError] when adding a comment fails',
        build: () {
          when(mockCommentRepository.addComment(any))
              .thenThrow(Exception('Failed to add comment'));
          return commentBloc;
        },
        act: (bloc) => bloc.add(AddComment(
            postId: testPostId, userId: testUserId, content: testContent)),
        expect: () => [
          CommentsLoading(),
          CommentError('Failed to add comment'),
        ],
      );
    });
  });
}
