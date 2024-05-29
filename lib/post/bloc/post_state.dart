// post_state.dart
import 'package:equatable/equatable.dart';
import '../model/post.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {}

class PostFailure extends PostState {
  final String error;

  PostFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostLoadingDetails extends PostState {}

class PostLoadingDetailsError extends PostState {
  final String error;

  PostLoadingDetailsError({required this.error});

  @override
  List<Object?> get props => [error];
}
