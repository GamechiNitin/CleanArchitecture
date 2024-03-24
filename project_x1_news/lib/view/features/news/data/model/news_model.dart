import 'package:project_x1_news/view/features/news/domain/entities/news.dart';

class NewsModel extends News {
  NewsModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topic,
    super.updateAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topic': topic,
      'updated_at': updateAt?.toIso8601String(),
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      topic: map['topic'].cast<String>(),
      updateAt: DateTime.parse(map['updated_at']),
    );
  }
  NewsModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topic,
    DateTime? updateAt,
  }) {
    return NewsModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topic: topic ?? this.topic,
      updateAt: updateAt ?? this.updateAt,
    );
  }
}
