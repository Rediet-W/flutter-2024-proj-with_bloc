import 'package:equatable/equatable.dart';
import 'dart:typed_data';
import 'dart:io';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreatePost extends PostEvent {
  final String category;
  final String description;
  final String location;
  final String time;
  final List<int>? pictureBuffer;

  CreatePost({
    required this.category,
    required this.description,
    required this.location,
    required this.time,
    this.pictureBuffer,
  });

  @override
  List<Object?> get props =>
      [category, description, location, time, pictureBuffer];
}

class LoadPost extends PostEvent {
  final String postId;

  LoadPost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class DescriptionChanged extends PostEvent {
  final String description;
  DescriptionChanged(this.description);
}

class ImagePicked extends PostEvent {
  final String imagePath;
  ImagePicked(this.imagePath);
}

class SubmitForm extends PostEvent {
  final String location;
  final String time;
  final String description;
  final Uint8List imageData;
  SubmitForm(this.location, this.time, this.description, this.imageData);
}
