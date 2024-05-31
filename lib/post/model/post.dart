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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Post otherPost = other as Post;
    return title == otherPost.title &&
        description == otherPost.description &&
        location == otherPost.location &&
        time == otherPost.time &&
        (imageBuffer == otherPost.imageBuffer ||
            (imageBuffer != null &&
                otherPost.imageBuffer != null &&
                imageBuffer!.length == otherPost.imageBuffer!.length &&
                _compareUint8Lists(imageBuffer!, otherPost.imageBuffer!)));
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        location.hashCode ^
        time.hashCode ^
        (imageBuffer?.hashCode ?? 0);
  }

  bool _compareUint8Lists(Uint8List list1, Uint8List list2) {
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }
}
