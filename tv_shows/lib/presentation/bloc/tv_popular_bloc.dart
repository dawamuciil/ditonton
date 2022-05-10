import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_shows/domain/entities/tv.dart';
import 'package:tv_shows/domain/usecases/get_popular_tvs.dart';

part 'event/tv_popular_event.dart';
part 'state/tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv _getPopGetPopularTv;

  TvPopularBloc(this._getPopGetPopularTv) : super(TvPopularEmpty()) {
    on<FetchTvPopular>(
      (event, emit) async {
        emit(TvPopularLoading());

        final popularResult = await _getPopGetPopularTv.execute();

        popularResult.fold(
          (failure) {
            emit(TvPopularError(failure.message));
          },
          (data) {
            emit(TvPopularHasData(data));
          },
        );
      },
    );
  }
}
