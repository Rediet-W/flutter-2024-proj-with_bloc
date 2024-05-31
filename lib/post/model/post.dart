import 'dart:convert';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final String location;
  final String description;
  final Uint8List pictureBuffer;

  Post({
    required this.id,
    required this.location,
    required this.description,
    required this.pictureBuffer,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      pictureBuffer: base64Decode(json['picture'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'description': description,
      'picture': base64Encode(pictureBuffer),
    };
  }

  @override
  List<Object?> get props => [id, location, description, pictureBuffer];
}
