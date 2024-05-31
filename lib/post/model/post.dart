import 'dart:typed_data';
import 'package:mongo_dart/mongo_dart.dart';

class Post {
  final String? id;
  final String category;
  final String description;
  final String location;
  final String time;
  final Uint8List? pictureBuffer;

  Post({
    this.id,
    required this.category,
    required this.description,
    required this.location,
    required this.time,
    this.pictureBuffer,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      category: json[' category'] ?? 'No  category',
      description: json['description'] ?? 'No description',
      location: json['location'] ?? 'No location',
      time: json['time'] ?? 'No time',
      pictureBuffer: json['picture'] != null
          ? Uint8List.fromList(List<int>.from(json['picture']['data']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'location': location,
      'time': time,
      'pictureBuffer': pictureBuffer,
    };
  }
}
