import 'dart:async';

import 'package:assignment_kalpas/data/essential_url/essential_url.dart';
import 'package:assignment_kalpas/data/favourite_article/favourite_article.dart';
import 'package:assignment_kalpas/service/api_service/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../model/News_data/news_data.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsInitialEvent>(newsInitialEvent);
    on<NewsDataFetchingEvent>(newsDataFetchingEvent);
    on<NewsGettingMarkedAsFavourite>(newsGettingMarkedAsFavourite);
    on<NewsGettingUnMarkedAsFavourite>(newsGettingUnMarkedAsFavourite);
  }

  FutureOr<void> newsInitialEvent(
      NewsInitialEvent event, Emitter<NewsState> emit) {
    emit(NewsLoadingState());
    add(NewsDataFetchingEvent());
  }

  FutureOr<void> newsDataFetchingEvent(
      NewsDataFetchingEvent event, Emitter<NewsState> emit) async {
    final newsData = await ApiService.getNewsDataFromApi(url);
    if (newsData[0].responseStatus != 200) {
      emit(NewsLoadingErrorState());
    } else {
      emit(NewsLoadingSuccessState(news: newsData));
    }
  }

  FutureOr<void> newsGettingMarkedAsFavourite(
      NewsGettingMarkedAsFavourite event, Emitter<NewsState> emit) {
    bool checkExistence = false;
    for (var element in favouriteArticle) {
      if (event.markedAsFavouriteArticle.title == element.title) {
        checkExistence = true;
      }
    }
    if (checkExistence == false) {
      favouriteArticle.add(event.markedAsFavouriteArticle);
    }
  }

  FutureOr<void> newsGettingUnMarkedAsFavourite(
      NewsGettingUnMarkedAsFavourite event, Emitter<NewsState> emit) {
    favouriteArticle.remove(event.unmarkedAsFavouriteArticle);
  }
}
