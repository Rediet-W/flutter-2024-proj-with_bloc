import 'dart:typed_data';

class Post {
  final String title;
  final String description;
  final String location;
  final String time;
  final Uint8List? imageBuffer;

  Post({
    required this.title,
    required this.description,
    required this.location,
    required this.time,
    this.imageBuffer,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      location: json['location'] ?? 'No location',
      time: json['time'] ?? 'No time',
      imageBuffer: json['picture'] != null
          ? Uint8List.fromList(List<int>.from(json['picture']['data']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'time': time,
      'imageBuffer': imageBuffer,
    };
  }
}
