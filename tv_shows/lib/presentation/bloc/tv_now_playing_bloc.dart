import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_shows/domain/entities/tv.dart';
import 'package:tv_shows/domain/usecases/get_now_playing_tvs.dart';

part 'event/tv_now_playing_event.dart';
part 'state/tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTv _getNowPlayingTv;

  TvNowPlayingBloc(this._getNowPlayingTv) : super(TvNowPlayingEmpty()) {
    on<FetchTvNowPlaying>(
      (event, emit) async {
        emit(TvNowPlayingLoading());

        final nowPlayingResult = await _getNowPlayingTv.execute();

        nowPlayingResult.fold(
          (failure) {
            emit(TvNowPlayingError(failure.message));
          },
          (data) {
            emit(TvNowPlayingHasData(data));
          },
        );
      },
    );
  }
}
