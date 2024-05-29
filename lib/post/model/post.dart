import 'dart:convert';

import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String title;
  final String description;
  final String location;
  final String time;
  final List<int> imageBuffer; // Assuming image is stored as a buffer

  Post({
    required this.title,
    required this.description,
    required this.location,
    required this.time,
    required this.imageBuffer,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      time: json['time'],
      imageBuffer: json[
          'imageBuffer'], // Assuming 'imageBuffer' is the key for the image buffer in JSON
    );
  }

  String get imageUrl {
    // Convert image buffer to base64 and create a data URL
    String base64Image = base64Encode(imageBuffer);
    return 'data:image/png;base64,$base64Image';
  }

  @override
  List<Object?> get props => [title, description, location, time, imageBuffer];
}
