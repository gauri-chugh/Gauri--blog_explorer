class Blog {
  final String id;
  final String title;
  final String imageUrl;
  final String content;

  Blog({required this.id, required this.title, required this.imageUrl, required this.content});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'content': content,
    };
  }
}
