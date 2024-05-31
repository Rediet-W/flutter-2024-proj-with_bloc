import 'package:equatable/equatable.dart';
import '../model/comment.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentsLoading extends CommentState {}

class CommentSuccess extends CommentState {}

class CommentsLoaded extends CommentState {
  final List<Comment> comments;

  const CommentsLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentError extends CommentState {
  final String message;

  const CommentError(this.message);

  @override
  List<Object> get props => [message];
}

class CommentDeleted extends CommentState {}

class CommentEdited extends CommentState {}
