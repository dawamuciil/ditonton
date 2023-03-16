part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class NowPlayingEvent extends MovieEvent {}

class PopularEvent extends MovieEvent {}

class TopRatedEvent extends MovieEvent {}

class DetailMovieEvent extends MovieEvent {
  final int id;

  const DetailMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RecommendedEvent extends MovieEvent {
  final int id;

  const RecommendedEvent(this.id);

  @override
  List<Object> get props => [id];
}

class WatchlistEvent extends MovieEvent {}

class SaveWatchlistEvent extends MovieEvent {
  final MovieDetail movie;

  const SaveWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistEvent extends MovieEvent {
  final MovieDetail movie;

  const RemoveWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistStatusEvent extends MovieEvent {
  final int id;

  const WatchlistStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}
