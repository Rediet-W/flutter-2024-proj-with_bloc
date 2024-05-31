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
      final List<Comment> testComments = [
        Comment(
          id: '1',
          userId: 'user1',
          content: 'Comment 1',
        ),
        Comment(
          id: '2',
          userId: 'user2',
          content: 'Comment 2',
        ),
      ];

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentsLoaded] when comments are loaded successfully',
        build: () {
          when(mockCommentRepository.fetchComments())
              .thenAnswer((_) async => testComments);
          return commentBloc;
        },
        act: (bloc) => bloc.add(LoadComments()),
        expect: () => [
          CommentsLoading(),
          CommentsLoaded(testComments),
        ],
        verify: (_) {
          verify(mockCommentRepository.fetchComments()).called(1);
        },
      );

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentError] when loading comments fails',
        build: () {
          when(mockCommentRepository.fetchComments())
              .thenThrow(Exception('Failed to load comments'));
          return commentBloc;
        },
        act: (bloc) => bloc.add(LoadComments()),
        expect: () => [
          CommentsLoading(),
          CommentError('Failed to load comments'),
        ],
      );
    });

    group('AddComment', () {
      const String testUserId = 'userId123';
      const String testContent = 'This is a comment';
      final Comment testComment = Comment(
        id: '1',
        userId: testUserId,
        content: testContent,
      );

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentSuccess] when adding a comment is successful',
        build: () {
          when(mockCommentRepository.addComment(any))
              .thenAnswer((_) async => testComment);
          return commentBloc;
        },
        act: (bloc) =>
            bloc.add(AddComment(userId: testUserId, content: testContent)),
        expect: () => [
          CommentsLoading(),
          CommentSuccess(),
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
        act: (bloc) =>
            bloc.add(AddComment(userId: testUserId, content: testContent)),
        expect: () => [
          CommentsLoading(),
          CommentError('Failed to add comment'),
        ],
      );
    });

    group('DeleteComment', () {
      const String testCommentId = 'commentId123';

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentDeleted, CommentsLoading, CommentsLoaded] when deleting a comment is successful',
        build: () {
          when(mockCommentRepository.deleteComment(testCommentId))
              .thenAnswer((_) async => Future.value());
          when(mockCommentRepository.fetchComments())
              .thenAnswer((_) async => []);
          return commentBloc;
        },
        act: (bloc) => bloc.add(DeleteComment(commentId: testCommentId)),
        expect: () => [
          CommentsLoading(),
          CommentDeleted(),
          CommentsLoading(), // LoadComments called after delete
          CommentsLoaded([]), // Expecting empty list after delete
        ],
        verify: (_) {
          verify(mockCommentRepository.deleteComment(testCommentId)).called(1);
          verify(mockCommentRepository.fetchComments()).called(1);
        },
      );

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentError] when deleting a comment fails',
        build: () {
          when(mockCommentRepository.deleteComment(testCommentId))
              .thenThrow(Exception('Failed to delete comment'));
          return commentBloc;
        },
        act: (bloc) => bloc.add(DeleteComment(commentId: testCommentId)),
        expect: () => [
          CommentsLoading(),
          CommentError('Failed to delete comment'),
        ],
      );
    });

    group('EditComment', () {
      const String testCommentId = 'commentId123';
      const String updatedContent = 'Updated comment content';

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentEdited, CommentsLoading, CommentsLoaded] when editing a comment is successful',
        build: () {
          when(mockCommentRepository.editComment(testCommentId, updatedContent))
              .thenAnswer((_) async => Future.value());
          when(mockCommentRepository.fetchComments())
              .thenAnswer((_) async => []);
          return commentBloc;
        },
        act: (bloc) => bloc.add(
            EditComment(commentId: testCommentId, content: updatedContent)),
        expect: () => [
          CommentsLoading(),
          CommentEdited(),
          CommentsLoading(), // LoadComments called after edit
          CommentsLoaded([]), // Expecting empty list or updated list
        ],
        verify: (_) {
          verify(mockCommentRepository.editComment(
                  testCommentId, updatedContent))
              .called(1);
          verify(mockCommentRepository.fetchComments()).called(1);
        },
      );

      blocTest<CommentBloc, CommentState>(
        'emits [CommentsLoading, CommentError] when editing a comment fails',
        build: () {
          when(mockCommentRepository.editComment(testCommentId, updatedContent))
              .thenThrow(Exception('Failed to edit comment'));
          return commentBloc;
        },
        act: (bloc) => bloc.add(
            EditComment(commentId: testCommentId, content: updatedContent)),
        expect: () => [
          CommentsLoading(),
          CommentError('Failed to edit comment'),
        ],
      );
    });
  });
}
