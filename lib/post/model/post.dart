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

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (runtimeType != other.runtimeType) return false;
//     final Post otherPost = other as Post;
//     return title == otherPost.title &&
//         description == otherPost.description &&
//         location == otherPost.location &&
//         time == otherPost.time &&
//         (imageBuffer == otherPost.imageBuffer ||
//             (imageBuffer != null &&
//                 otherPost.imageBuffer != null &&
//                 imageBuffer!.length == otherPost.imageBuffer!.length &&
//                 _compareUint8Lists(imageBuffer!, otherPost.imageBuffer!)));
//   }

//   @override
//   int get hashCode {
//     return title.hashCode ^
//         description.hashCode ^
//         location.hashCode ^
//         time.hashCode ^
//         (imageBuffer?.hashCode ?? 0);
//   }

//   bool _compareUint8Lists(Uint8List list1, Uint8List list2) {
//     for (int i = 0; i < list1.length; i++) {
//       if (list1[i] != list2[i]) {
//         return false;
//       }
//     }
//     return true;
//   }
}
