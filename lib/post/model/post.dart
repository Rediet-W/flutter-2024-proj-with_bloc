class Post {
  final String title;
  final String description;
  final String location;
  final String time;

  Post({
    required this.title,
    required this.description,
    required this.location,
    required this.time,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'time': time,
    };
  }
}
