class News {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final String? posterName;
  final List<String>? topic;
  final DateTime? updateAt;

  News({
    this.posterName,
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    this.topic,
    this.updateAt,
  });
}
