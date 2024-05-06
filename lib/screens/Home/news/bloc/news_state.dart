part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

sealed class NewsActionState extends NewsState {}

final class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadingSuccessState extends NewsState {
  final List<News> news ;

  NewsLoadingSuccessState({required this.news});
}

class NewsLoadingErrorState extends NewsState {}

class NewsNavigateToDescriptionActionState extends NewsActionState {}

class NewsNavigateToFavouriteActionState extends NewsActionState {}
