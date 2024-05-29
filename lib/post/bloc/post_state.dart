import 'package:equatable/equatable.dart';

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
  final Map<String, dynamic> postDetails;

  PostLoaded(this.postDetails);

  @override
  List<Object?> get props => [postDetails];
}

class PostLoadingDetails extends PostState {}

class PostLoadingDetailsError extends PostState {
  final String error;

  PostLoadingDetailsError({required this.error});

  @override
  List<Object?> get props => [error];
}
