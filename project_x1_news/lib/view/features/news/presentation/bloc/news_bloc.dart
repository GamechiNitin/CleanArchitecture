import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_x1_news/core/usecase/usecase.dart';
import 'package:project_x1_news/view/features/news/domain/entities/news.dart';
import 'package:project_x1_news/view/features/news/domain/usecases/get_news.dart';
import 'package:project_x1_news/view/features/news/domain/usecases/upload_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final UploadNewsUseCase _uploadNewsUseCase;
  final GetNewsUseCase _getNewsUseCase;
  NewsBloc({
    required UploadNewsUseCase uploadNewsUseCase,
    required GetNewsUseCase getNewsUseCase,
  })  : _uploadNewsUseCase = uploadNewsUseCase,
        _getNewsUseCase = getNewsUseCase,
        super(NewsInitial()) {
    on<UploadNewsEvent>(uploadNewsEvent);
    on<GetNewsListEvent>(getNewsListEvent);
  }

  FutureOr<void> uploadNewsEvent(
      UploadNewsEvent event, Emitter<NewsState> emit) async {
    emit(LoadingNews());
    final response = await _uploadNewsUseCase(
      UploadNewsParams(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topic: event.topic,
      ),
    );
    log(response.toString());
    response.fold((l) {
      emit(StopLoadingNews());
      emit(FailureNews(l.message));
    }, (r) {
      emit(StopLoadingNews());
      emit(SuccessNews(r));
    });
  }

  FutureOr<void> getNewsListEvent(
      GetNewsListEvent event, Emitter<NewsState> emit) async {
    emit(LoadingNews());
    final response = await _getNewsUseCase(NoParams());
    log(response.toString());
    response.fold((l) {
      emit(StopLoadingNews());
      emit(FailureNews(l.message));
    }, (r) {
      emit(StopLoadingNews());
      emit(NewsListDataState(r));
    });
  }
}
