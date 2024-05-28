import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/comment_repository.dart';
import 'comment_event.dart';
import 'comment_state.dart';
import '../model/comment.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc({required this.commentRepository}) : super(CommentInitial()) {
    on<LoadComments>((event, emit) async {
      emit(CommentsLoading());

      try {
        final comments = await commentRepository.fetchComments(event.postId);
        emit(CommentsLoaded(comments));
      } catch (e) {
        emit(CommentError('Failed to load comments'));
      }
    });

    on<AddComment>((event, emit) async {
      emit(CommentsLoading());

      try {
        final newComment = Comment(
          id: '', // Server-generated ID
          postId: event.postId,
          userId: event.userId,
          content: event.content,
          timestamp: DateTime.now(),
        );
        final comment = await commentRepository.addComment(newComment);
        final currentState = state;
        if (currentState is CommentsLoaded) {
          emit(CommentsLoaded(List.from(currentState.comments)..add(comment)));
        } else {
          emit(CommentsLoaded([comment]));
        }
      } catch (e) {
        emit(CommentError('Failed to add comment'));
      }
    });
  }
}
