part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class OnAiringEvent extends TvEvent {}

class PopularTvEvent extends TvEvent {}

class TopRatedTvEvent extends TvEvent {}

class DetailTvEvent extends TvEvent {
  final int id;

  const DetailTvEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RecommendedTvEvent extends TvEvent {
  final int id;

  const RecommendedTvEvent(this.id);

  @override
  List<Object> get props => [id];
}

class WatchlistTvEvent extends TvEvent {}

class SaveWatchlistTvEvent extends TvEvent {
  final TvSeriesDetail tv;

  const SaveWatchlistTvEvent(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveWatchlistTvEvent extends TvEvent {
  final TvSeriesDetail tv;

  const RemoveWatchlistTvEvent(this.tv);

  @override
  List<Object> get props => [tv];
}

class WatchlistStatusTvEvent extends TvEvent {
  final int id;

  const WatchlistStatusTvEvent(this.id);

  @override
  List<Object> get props => [id];
}
