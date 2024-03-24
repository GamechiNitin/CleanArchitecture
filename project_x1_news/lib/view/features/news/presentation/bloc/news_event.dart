part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

final class UploadNewsEvent extends NewsEvent {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topic;

  UploadNewsEvent({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topic,
  });
}
