import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

class LoadComments extends CommentEvent {}

class AddComment extends CommentEvent {
  final String? userId;
  final String content;

  AddComment({
    required this.userId,
    required this.content,
  });

  @override
  List<Object?> get props => [userId, content];
}

class DeleteComment extends CommentEvent {
  final String? commentId;

  DeleteComment({required this.commentId});
}

class EditComment extends CommentEvent {
  final String? commentId;
  final String content;

  EditComment({required this.commentId, required this.content});
}
