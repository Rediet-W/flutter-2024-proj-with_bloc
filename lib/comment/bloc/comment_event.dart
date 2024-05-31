import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadComments extends CommentEvent {
  final String postId;

  LoadComments(ObjectId postId) : postId = postId.$oid;

  @override
  List<Object> get props => [postId];
}

class AddComment extends CommentEvent {
  final String postId;
  final String userId;
  final String content;

  AddComment({
    required postId,
    required userId,
    required this.content,
  })  : postId = postId,
        userId = userId;

  @override
  List<Object> get props => [postId, userId, content];
}
