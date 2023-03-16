import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies playingMovies;
  final GetPopularMovies popularMovies;
  final GetTopRatedMovies topRatedMovies;
  final GetMovieDetail detailMovies;
  final GetMovieRecommendations recommendationMovies;
  final GetWatchlistMovies watchlistMovies;
  final GetWatchListStatus watchlistStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieBloc({
    required this.playingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.detailMovies,
    required this.recommendationMovies,
    required this.watchlistMovies,
    required this.watchlistStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieState.initial()) {
    on<NowPlayingEvent>((_fetchNowPlaying));
    on<PopularEvent>((_fetchPopular));
    on<TopRatedEvent>((_fetchTopRated));
    on<DetailMovieEvent>((_fetchDetail));
    on<RecommendedEvent>((_fetchRecommendation));
    on<WatchlistEvent>((_fetchWatchlist));
    on<SaveWatchlistEvent>((_saveWatchlist));
    on<RemoveWatchlistEvent>((_removeWatchlist));
    on<WatchlistStatusEvent>((_fetchWatchlistStatus));
  }

  FutureOr<void> _fetchNowPlaying(event, emit) async {
    emit(state.copyWith(
      nowPlayingState: RequestState.loading,
    ));
    final result = await playingMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          nowPlayingState: RequestState.error,
          message: failure.message,
        ));
      },
      (data) {
        if (data.isNotEmpty) {
          emit(state.copyWith(
            nowPlayingState: RequestState.success,
            nowPlayingList: data,
          ));
        } else {
          emit(state.copyWith(
            nowPlayingState: RequestState.empty,
            message: 'Now playing movie is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _fetchPopular(event, emit) async {
    emit(state.copyWith(
      popularState: RequestState.loading,
    ));
    final result = await popularMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          popularState: RequestState.error,
          message: failure.message,
        ));
      },
      (data) {
        if (data.isNotEmpty) {
          emit(state.copyWith(
            popularState: RequestState.success,
            popularList: data,
          ));
        } else {
          emit(state.copyWith(
            popularState: RequestState.empty,
            message: 'Popular movie is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _fetchTopRated(event, emit) async {
    emit(state.copyWith(
      topRatedState: RequestState.loading,
    ));
    final result = await topRatedMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedState: RequestState.error,
          message: failure.message,
        ));
      },
      (data) {
        if (data.isNotEmpty) {
          emit(state.copyWith(
            topRatedState: RequestState.success,
            topRatedList: data,
          ));
        } else {
          emit(state.copyWith(
            topRatedState: RequestState.empty,
            message: 'Top rated movie is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _fetchDetail(event, emit) async {
    emit(state.copyWith(
      detailState: RequestState.loading,
    ));
    final result = await detailMovies.execute(event.id);

    result.fold(
      (failure) {
        emit(state.copyWith(
          detailState: RequestState.error,
          message: failure.message,
        ));
      },
      (data) {
        add(RecommendedEvent(event.id));

        emit(state.copyWith(
          detailState: RequestState.success,
          detailMovie: data,
        ));
      },
    );
  }

  FutureOr<void> _fetchRecommendation(event, emit) async {
    emit(state.copyWith(
      recommendationState: RequestState.loading,
    ));
    final result = await recommendationMovies.execute(event.id);

    result.fold(
      (failure) {
        emit(state.copyWith(
          recommendationState: RequestState.error,
          message: failure.message,
        ));
      },
      (data) {
        if (data.isNotEmpty) {
          emit(state.copyWith(
            recommendationState: RequestState.success,
            recommendationList: data,
          ));
        } else {
          emit(state.copyWith(
            recommendationState: RequestState.empty,
            message: 'Recommendation movie is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _fetchWatchlist(event, emit) async {
    emit(state.copyWith(
      watchlistState: RequestState.loading,
    ));
    final result = await watchlistMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.error,
          message: failure.message,
        ));
      },
      (data) {
        if (data.isNotEmpty) {
          emit(state.copyWith(
            watchlistState: RequestState.success,
            watchlistList: data,
          ));
        } else {
          emit(state.copyWith(
            watchlistState: RequestState.empty,
            message: 'Watchlist movie is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _saveWatchlist(event, emit) async {
    final result = await saveWatchlist.execute(event.movie);

    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          message: data,
        ));
      },
    );

    add(WatchlistStatusEvent(event.movie.id));
  }

  FutureOr<void> _removeWatchlist(event, emit) async {
    final result = await removeWatchlist.execute(event.movie);

    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          message: data,
        ));
      },
    );

    add(WatchlistStatusEvent(event.movie.id));
  }

  FutureOr<void> _fetchWatchlistStatus(event, emit) async {
    final result = await watchlistStatus.execute(event.id);
    emit(state.copyWith(
      watchlistStatus: result,
      message: '',
    ));
  }
}
