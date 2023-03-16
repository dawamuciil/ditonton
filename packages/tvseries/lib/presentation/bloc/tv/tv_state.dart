part of 'tv_bloc.dart';

class TvState extends Equatable {
  final RequestState onAiringState;
  final RequestState popularState;
  final RequestState topRatedState;
  final RequestState detailState;
  final RequestState recommendationState;
  final RequestState watchlistState;

  final List<TvSeries> onAiringList;
  final List<TvSeries> popularList;
  final List<TvSeries> topRatedList;
  final List<TvSeries> recommendationList;
  final List<TvSeries> watchlistList;
  final TvSeriesDetail? detailTv;
  final TvSeriesDetail? saveWatchlist;
  final TvSeriesDetail? removeWatchlist;
  final bool watchlistStatus;

  final String message;

  const TvState({
    required this.onAiringState,
    required this.popularState,
    required this.topRatedState,
    required this.recommendationState,
    required this.watchlistState,
    required this.detailState,
    required this.onAiringList,
    required this.popularList,
    required this.topRatedList,
    required this.recommendationList,
    required this.watchlistList,
    required this.detailTv,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.watchlistStatus,
    required this.message,
  });

  factory TvState.initial() {
    return const TvState(
      onAiringState: RequestState.empty,
      popularState: RequestState.empty,
      topRatedState: RequestState.empty,
      recommendationState: RequestState.empty,
      watchlistState: RequestState.empty,
      detailState: RequestState.empty,
      onAiringList: [],
      popularList: [],
      topRatedList: [],
      recommendationList: [],
      watchlistList: [],
      detailTv: null,
      saveWatchlist: null,
      removeWatchlist: null,
      watchlistStatus: false,
      message: '',
    );
  }

  TvState copyWith({
    RequestState? onAiringState,
    RequestState? popularState,
    RequestState? topRatedState,
    RequestState? recommendationState,
    RequestState? watchlistState,
    RequestState? detailState,
    RequestState? saveWatchlistState,
    RequestState? removeWatchlistState,
    List<TvSeries>? onAiringList,
    List<TvSeries>? popularList,
    List<TvSeries>? topRatedList,
    List<TvSeries>? recommendationList,
    List<TvSeries>? watchlistList,
    TvSeriesDetail? detailTv,
    TvSeriesDetail? saveWatchlist,
    TvSeriesDetail? removeWatchlist,
    bool? watchlistStatus,
    String? message,
  }) {
    return TvState(
      onAiringState: onAiringState ?? this.onAiringState,
      popularState: popularState ?? this.popularState,
      topRatedState: topRatedState ?? this.topRatedState,
      recommendationState: recommendationState ?? this.recommendationState,
      watchlistState: watchlistState ?? this.watchlistState,
      detailState: detailState ?? this.detailState,
      onAiringList: onAiringList ?? this.onAiringList,
      popularList: popularList ?? this.popularList,
      topRatedList: topRatedList ?? this.topRatedList,
      recommendationList: recommendationList ?? this.recommendationList,
      watchlistList: watchlistList ?? this.watchlistList,
      detailTv: detailTv ?? this.detailTv,
      saveWatchlist: saveWatchlist ?? this.saveWatchlist,
      removeWatchlist: removeWatchlist ?? this.removeWatchlist,
      watchlistStatus: watchlistStatus ?? this.watchlistStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props {
    return [
      onAiringState,
      popularState,
      topRatedState,
      recommendationState,
      watchlistState,
      detailState,
      onAiringList,
      popularList,
      topRatedList,
      recommendationList,
      watchlistList,
      detailTv,
      saveWatchlist,
      removeWatchlist,
      watchlistStatus,
      message,
    ];
  }
}
