import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_shows/domain/entities/tv.dart';
import 'package:tv_shows/domain/entities/tv_detail.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv_shows/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv_shows/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_shows/domain/usecases/save_tv_watchlist.dart';

part 'event/tv_watchlist_event.dart';
part 'state/tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTv _getTvWatchlist;
  final GetWatchListStatusTv _getWatchListTvStatus;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  TvWatchlistBloc(this._getTvWatchlist, this._getWatchListTvStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(TvWatchlistEmpty()) {
    on<FetchTvWatchlist>(
      (event, emit) async {
        emit(TvWatchlistLoading());
        final watchlistResult = await _getTvWatchlist.execute();

        watchlistResult.fold(
          (failure) {
            emit(TvWatchlistError(failure.message));
          },
          (data) {
            emit(TvWatchlistHasData(data));
          },
        );
      },
    );
    on<LoadWatchlistStatus>(((event, emit) async {
      final id = event.id;
      final result = await _getWatchListTvStatus.execute(id);

      emit(WatchlistHasData(result));
    }));
    on<AddTvWatchlist>((event, emit) async {
      final tv = event.tv;

      final result = await _saveWatchlist.execute(tv);

      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) => emit(const WatchlistSuccess('Added to Watchlist')),
      );

      add(LoadWatchlistStatus(tv.id));
    });

    on<DeleteTvWatchlist>((event, emit) async {
      final tv = event.tv;

      final result = await _removeWatchlist.execute(tv);
      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) =>
            emit(const WatchlistSuccess('Removed from Watchlist')),
      );
      add(LoadWatchlistStatus(tv.id));
    });
  }
}
