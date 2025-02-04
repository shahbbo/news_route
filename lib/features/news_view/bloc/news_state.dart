part of 'news_cubit.dart';

sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsChangeSelectedIndex extends NewsState {}

final class NewsError extends NewsState {
  final String error;
  NewsError(this.error);
}

final class NewsLoading extends NewsState {}

final class NewsSuccess extends NewsState {
  final List<News> newsList;
  NewsSuccess(this.newsList);
}