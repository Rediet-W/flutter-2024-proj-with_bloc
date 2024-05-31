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
        final comments = await commentRepository.fetchComments();
        emit(CommentsLoaded(comments));
      } catch (e) {
        emit(CommentError(e is Exception
            ? e.toString().replaceFirst('Exception: ', '')
            : e.toString()));
      }
    });

    on<AddComment>((event, emit) async {
      emit(CommentsLoading());

      try {
        final newComment = Comment(
          userId: event.userId,
          content: event.content,
        );

        final comment = await commentRepository.addComment(newComment);
        emit(CommentSuccess());
      } catch (e) {
        emit(CommentError(e is Exception
            ? e.toString().replaceFirst('Exception: ', '')
            : e.toString()));
      }
    });

    on<DeleteComment>((event, emit) async {
      emit(CommentsLoading());

      try {
        await commentRepository.deleteComment(event.commentId);
        emit(CommentDeleted());
        add(LoadComments());
      } catch (e) {
        emit(CommentError(e is Exception
            ? e.toString().replaceFirst('Exception: ', '')
            : e.toString()));
      }
    });

    on<EditComment>((event, emit) async {
      emit(CommentsLoading());

      try {
        await commentRepository.editComment(event.commentId, event.content);
        emit(CommentEdited());
        add(LoadComments());
      } catch (e) {
        emit(CommentError(e is Exception
            ? e.toString().replaceFirst('Exception: ', '')
            : e.toString()));
      }
    });
  }
}
