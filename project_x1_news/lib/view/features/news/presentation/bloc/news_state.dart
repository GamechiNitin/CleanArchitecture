part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsActionState extends NewsState {}

final class LoadingNews extends NewsState {}

final class StopLoadingNews extends NewsState {}

final class SuccessNews extends NewsActionState {
  final News uid;

  SuccessNews(this.uid);
}

final class NewsListDataState extends NewsActionState {
  final List<News> data;

  NewsListDataState(this.data);
}

final class FailureNews extends NewsActionState {
  final String message;

  FailureNews(this.message);
}
