import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/comment_repository.dart';
import 'comment_event.dart';
import 'comment_state.dart';
import '../model/comment.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../secure_storage_service.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  final SecureStorageService _secureStorageService = SecureStorageService();

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
          postId: event.postId,
          userId: event.userId,
          content: event.content,
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

  Future<String> getUserId() async {
    final userId = await _secureStorageService.readToken();
    if (userId == null) {
      throw Exception('User ID not found in secure storage');
    }
    return userId;
  }
}
