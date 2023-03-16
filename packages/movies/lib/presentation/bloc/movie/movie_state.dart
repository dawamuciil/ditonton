part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final RequestState nowPlayingState;
  final RequestState popularState;
  final RequestState topRatedState;
  final RequestState recommendationState;
  final RequestState watchlistState;
  final RequestState detailState;

  final List<Movie> nowPlayingList;
  final List<Movie> popularList;
  final List<Movie> topRatedList;
  final List<Movie> recommendationList;
  final List<Movie> watchlistList;
  final MovieDetail? detailMovie;
  final MovieDetail? saveWatchlist;
  final MovieDetail? removeWatchlist;
  final bool watchlistStatus;

  final String message;

  const MovieState({
    required this.nowPlayingState,
    required this.popularState,
    required this.topRatedState,
    required this.recommendationState,
    required this.watchlistState,
    required this.detailState,
    required this.nowPlayingList,
    required this.popularList,
    required this.topRatedList,
    required this.recommendationList,
    required this.watchlistList,
    required this.detailMovie,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.watchlistStatus,
    required this.message,
  });

  factory MovieState.initial() {
    return const MovieState(
      nowPlayingState: RequestState.empty,
      popularState: RequestState.empty,
      topRatedState: RequestState.empty,
      recommendationState: RequestState.empty,
      watchlistState: RequestState.empty,
      detailState: RequestState.empty,
      nowPlayingList: [],
      popularList: [],
      topRatedList: [],
      recommendationList: [],
      watchlistList: [],
      detailMovie: null,
      saveWatchlist: null,
      removeWatchlist: null,
      watchlistStatus: false,
      message: '',
    );
  }

  MovieState copyWith({
    RequestState? nowPlayingState,
    RequestState? popularState,
    RequestState? topRatedState,
    RequestState? recommendationState,
    RequestState? watchlistState,
    RequestState? detailState,
    RequestState? saveWatchlistState,
    RequestState? removeWatchlistState,
    List<Movie>? nowPlayingList,
    List<Movie>? popularList,
    List<Movie>? topRatedList,
    List<Movie>? recommendationList,
    List<Movie>? watchlistList,
    MovieDetail? detailMovie,
    MovieDetail? saveWatchlist,
    MovieDetail? removeWatchlist,
    bool? watchlistStatus,
    String? message,
  }) {
    return MovieState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularState: popularState ?? this.popularState,
      topRatedState: topRatedState ?? this.topRatedState,
      recommendationState: recommendationState ?? this.recommendationState,
      watchlistState: watchlistState ?? this.watchlistState,
      detailState: detailState ?? this.detailState,
      nowPlayingList: nowPlayingList ?? this.nowPlayingList,
      popularList: popularList ?? this.popularList,
      topRatedList: topRatedList ?? this.topRatedList,
      recommendationList: recommendationList ?? this.recommendationList,
      watchlistList: watchlistList ?? this.watchlistList,
      detailMovie: detailMovie ?? this.detailMovie,
      saveWatchlist: saveWatchlist ?? this.saveWatchlist,
      removeWatchlist: removeWatchlist ?? this.removeWatchlist,
      watchlistStatus: watchlistStatus ?? this.watchlistStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props {
    return [
      nowPlayingState,
      popularState,
      topRatedState,
      recommendationState,
      watchlistState,
      detailState,
      nowPlayingList,
      popularList,
      topRatedList,
      recommendationList,
      watchlistList,
      detailMovie,
      saveWatchlist,
      removeWatchlist,
      watchlistStatus,
      message,
    ];
  }
}
