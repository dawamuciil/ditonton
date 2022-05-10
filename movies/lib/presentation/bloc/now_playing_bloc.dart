import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'event/now_playing_event.dart';
part 'state/now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingBloc(this._getNowPlayingMovies) : super(NowPlayingEmpty());

  @override
  Stream<NowPlayingState> mapEventToState(
    NowPlayingEvent event,
  ) async* {
    if (event is FetchNowPlaying) {
      yield NowPlayingLoading();
      final result = await _getNowPlayingMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield NowPlayingError(failure.message);
        },
        (data) async* {
          yield NowPlayingHasData(data);
        },
      );
    }
  }
}
