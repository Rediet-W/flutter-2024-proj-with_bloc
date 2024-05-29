import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreatePost extends PostEvent {
  final String title;
  final String description;
  final String location;
  final String time;

  CreatePost({
    required this.title,
    required this.description,
    required this.location,
    required this.time,
  });

  @override
  List<Object?> get props => [title, description, location, time];
}

class LoadPost extends PostEvent {
  final String postId;

  LoadPost(this.postId);

  @override
  List<Object?> get props => [postId];
}
