import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_shows/domain/entities/tv_detail.dart';
import 'package:tv_shows/domain/usecases/get_tv_detail.dart';

part 'event/tv_detail_event.dart';
part 'state/tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvDetailEmpty()) {
    on<FetchTvDetail>(
      (event, emit) async {
        final id = event.id;

        emit(TvDetailLoading());
        final detailResult = await _getTvDetail.execute(id);

        detailResult.fold(
          (failure) {
            emit(TvDetailError(failure.message));
          },
          (data) {
            emit(TvDetailHasData(data));
          },
        );
      },
    );
  }
}
