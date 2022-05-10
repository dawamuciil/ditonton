import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv_shows/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv_shows/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_shows/domain/usecases/save_tv_watchlist.dart';
import 'package:tv_shows/presentation/bloc/tv_watchlist_bloc.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistTv, GetWatchListStatusTv, SaveWatchlistTv, RemoveWatchlistTv])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchListTvStatus mockGetWatchlistTvStatus;
  late MockSaveTvWatchlist mockSaveWatchlistTv;
  late MockRemoveTvWatchlist mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchlistTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlistTv = MockSaveTvWatchlist();
    mockRemoveWatchlistTv = MockRemoveTvWatchlist();
    tvWatchlistBloc = TvWatchlistBloc(mockGetWatchlistTv,
        mockGetWatchlistTvStatus, mockSaveWatchlistTv, mockRemoveWatchlistTv);
  });

  test('initial state should be empty', () {
    expect(tvWatchlistBloc.state, TvWatchlistEmpty());
  });

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [TvWatchlistLoading, TvWatchlistHasData]  when detail data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvWatchlist()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [TvWatchlistLoading, TvWatchlistError] when detail data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvWatchlist()),
    expect: () => [
      TvWatchlistLoading(),
      const TvWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );
}
