import 'package:equatable/equatable.dart';
import '../model/post.dart'; // Import your Post model

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {}

class PostFailure extends PostState {
  final String error;

  const PostFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class PostLoaded extends PostState {
  final List<Post> posts; // Define posts as a list of Post objects

  const PostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostLoadingDetails extends PostState {}

class PostLoadingDetailsError extends PostState {
  final String error;

  const PostLoadingDetailsError({required this.error});

  @override
  List<Object?> get props => [error];
}
