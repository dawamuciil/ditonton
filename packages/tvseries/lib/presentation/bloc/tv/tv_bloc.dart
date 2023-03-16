import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final TvSeriesUseCase useCase;

  TvBloc({required this.useCase}) : super(TvState.initial()) {
    on<OnAiringEvent>((_fetchOnAiring));
    on<PopularTvEvent>((_fetchPopular));
    on<TopRatedTvEvent>((_fetchTopRated));
    on<DetailTvEvent>((_fetchDetail));
    on<RecommendedTvEvent>((_fetchRecommendation));
    on<WatchlistTvEvent>((_fetchWatchlist));
    on<SaveWatchlistTvEvent>((_saveWatchlist));
    on<RemoveWatchlistTvEvent>((_removeWatchlist));
    on<WatchlistStatusTvEvent>((_fetchWatchlistStatus));
  }

  FutureOr<void> _fetchOnAiring(event, emit) async {
    emit(state.copyWith(
      onAiringState: RequestState.loading,
    ));
    final result = await useCase.getOnAiringTv();

    result.fold(
      (failure) {
        emit(state.copyWith(
          onAiringState: RequestState.error,
          message: failure.message,
        ));
      },
      (data) {
        if (data.isNotEmpty) {
          emit(state.copyWith(
            onAiringState: RequestState.success,
            onAiringList: data,
          ));
        } else {
          emit(state.copyWith(
            onAiringState: RequestState.empty,
            message: 'On airing tv show is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _fetchPopular(event, emit) async {
    emit(state.copyWith(
      popularState: RequestState.loading,
    ));
    final result = await useCase.getPopularTv();

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
            message: 'Popular tv series is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _fetchTopRated(event, emit) async {
    emit(state.copyWith(
      topRatedState: RequestState.loading,
    ));
    final result = await useCase.getTopRatedTv();

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
            message: 'Top rated tv series is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _fetchDetail(event, emit) async {
    emit(state.copyWith(
      detailState: RequestState.loading,
    ));
    final result = await useCase.getTvDetail(event.id);

    result.fold(
      (failure) {
        emit(state.copyWith(
          detailState: RequestState.error,
          message: failure.message,
        ));
      },
      (data) {
        add(RecommendedTvEvent(event.id));

        emit(state.copyWith(
          detailState: RequestState.success,
          detailTv: data,
        ));
      },
    );
  }

  FutureOr<void> _fetchRecommendation(event, emit) async {
    emit(state.copyWith(
      recommendationState: RequestState.loading,
    ));
    final result = await useCase.getTvRecommendations(event.id);

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
            message: 'Recommendation tv series is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _fetchWatchlist(event, emit) async {
    emit(state.copyWith(
      watchlistState: RequestState.loading,
    ));
    final result = await useCase.getWatchlistTv();

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
            message: 'Watchlist tv series is empty',
          ));
        }
      },
    );
  }

  FutureOr<void> _saveWatchlist(event, emit) async {
    final result = await useCase.saveWatchlistTv(event.tv);

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

    add(WatchlistStatusTvEvent(event.tv.id));
  }

  FutureOr<void> _removeWatchlist(event, emit) async {
    final result = await useCase.removeWatchlistTv(event.tv);

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

    add(WatchlistStatusTvEvent(event.tv.id));
  }

  FutureOr<void> _fetchWatchlistStatus(event, emit) async {
    final result = await useCase.isAddedToWatchlist(event.id);
    emit(state.copyWith(
      watchlistStatus: result,
      message: '',
    ));
  }
}
