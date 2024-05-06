part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

class NewsInitialEvent extends NewsEvent {}

class NewsDataFetchingEvent extends NewsEvent {}

class NewsGettingMarkedAsFavourite extends NewsEvent {
  final News markedAsFavouriteArticle;

  NewsGettingMarkedAsFavourite({required this.markedAsFavouriteArticle});
}

class NewsGettingUnMarkedAsFavourite extends NewsEvent {
  final News unmarkedAsFavouriteArticle;

  NewsGettingUnMarkedAsFavourite({required this.unmarkedAsFavouriteArticle});
}

class NewsNavigateToDescription extends NewsEvent {}

class NewsNavigateToFavourite extends NewsEvent {
  final BuildContext context;

  NewsNavigateToFavourite({required this.context});
}
