import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_bloc_test.mocks.dart';

@GenerateMocks([TvSeriesUseCase])
void main() {
  late MockTvSeriesUseCase mockTvSeriesUseCase;
  late TvBloc tvBloc;

  setUp(() {
    mockTvSeriesUseCase = MockTvSeriesUseCase();
    tvBloc = TvBloc(useCase: mockTvSeriesUseCase);
  });

  test('initial state should be null or empty', () {
    expect(tvBloc.state, TvState.initial());
  });

  group('on airing tv', () {
    group('success', () {
      blocTest<TvBloc, TvState>(
        'should emit [Loading, Success] tv when data is gotten successfully',
        build: () {
          when(mockTvSeriesUseCase.getOnAiringTv())
              .thenAnswer((_) async => Right(tSeriesList));

          return tvBloc;
        },
        act: (bloc) => bloc.add(OnAiringEvent()),
        verify: (bloc) => verify(mockTvSeriesUseCase.getOnAiringTv()),
        expect: () => <TvState>[
          TvState.initial().copyWith(
            onAiringState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            onAiringState: RequestState.success,
            onAiringList: tSeriesList,
          ),
        ],
      );

      blocTest<TvBloc, TvState>(
        'should emit [Loading, Empty] tv when data is gotten successfully',
        build: () {
          when(mockTvSeriesUseCase.getOnAiringTv())
              .thenAnswer((_) async => const Right([]));

          return tvBloc;
        },
        act: (bloc) => bloc.add(OnAiringEvent()),
        verify: (bloc) => verify(mockTvSeriesUseCase.getOnAiringTv()),
        expect: () => <TvState>[
          TvState.initial().copyWith(
            onAiringState: RequestState.loading,
          ),
          TvState.initial().copyWith(
              onAiringState: RequestState.empty,
              message: 'On airing tv show is empty'),
        ],
      );
    });

    group('error', () {
      blocTest<TvBloc, TvState>(
        'should emit [Loading, Error] tv when data is gotten unsuccessful',
        build: () {
          when(mockTvSeriesUseCase.getOnAiringTv()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvBloc;
        },
        act: (bloc) => bloc.add(OnAiringEvent()),
        verify: (bloc) {
          verify(mockTvSeriesUseCase.getOnAiringTv());
        },
        expect: () => <TvState>[
          TvState.initial().copyWith(
            onAiringState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            onAiringState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });

  group('popular tv', () {
    group('success', () {
      blocTest<TvBloc, TvState>(
        'should emit [Loading, Success] tv when data is gotten successfully',
        build: () {
          when(mockTvSeriesUseCase.getPopularTv())
              .thenAnswer((_) async => Right(tSeriesList));

          return tvBloc;
        },
        act: (bloc) => bloc.add(PopularTvEvent()),
        verify: (bloc) {
          verify(mockTvSeriesUseCase.getPopularTv());
        },
        expect: () => <TvState>[
          TvState.initial().copyWith(
            popularState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            popularState: RequestState.success,
            popularList: tSeriesList,
          ),
        ],
      );

      blocTest<TvBloc, TvState>(
        'should emit [Loading, Empty] tv when data is gotten successfully',
        build: () {
          when(mockTvSeriesUseCase.getPopularTv())
              .thenAnswer((_) async => const Right([]));

          return tvBloc;
        },
        act: (bloc) => bloc.add(PopularTvEvent()),
        verify: (bloc) {
          verify(mockTvSeriesUseCase.getPopularTv());
        },
        expect: () => <TvState>[
          TvState.initial().copyWith(
            popularState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            popularState: RequestState.empty,
            message: 'Popular tv series is empty',
          ),
        ],
      );
    });

    group('error', () {
      blocTest<TvBloc, TvState>(
        'should emit [Loading, Error] tv when data is gotten unsuccessful',
        build: () {
          when(mockTvSeriesUseCase.getPopularTv()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvBloc;
        },
        act: (bloc) => bloc.add(PopularTvEvent()),
        verify: (bloc) {
          verify(mockTvSeriesUseCase.getPopularTv());
        },
        expect: () => <TvState>[
          TvState.initial().copyWith(
            popularState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            popularState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });

  group('top rated tv', () {
    group('success', () {
      blocTest<TvBloc, TvState>(
        'should emit [Loading, Success] tv when data is gotten successfully',
        build: () {
          when(mockTvSeriesUseCase.getTopRatedTv())
              .thenAnswer((_) async => Right(tSeriesList));

          return tvBloc;
        },
        act: (bloc) => bloc.add(TopRatedTvEvent()),
        verify: (bloc) {
          verify(mockTvSeriesUseCase.getTopRatedTv());
        },
        expect: () => <TvState>[
          TvState.initial().copyWith(
            topRatedState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            topRatedState: RequestState.success,
            topRatedList: tSeriesList,
          ),
        ],
      );

      blocTest<TvBloc, TvState>(
        'should emit [Loading, Empty] tv when data is gotten successfully',
        build: () {
          when(mockTvSeriesUseCase.getTopRatedTv())
              .thenAnswer((_) async => const Right([]));

          return tvBloc;
        },
        act: (bloc) => bloc.add(TopRatedTvEvent()),
        verify: (bloc) {
          verify(mockTvSeriesUseCase.getTopRatedTv());
        },
        expect: () => <TvState>[
          TvState.initial().copyWith(
            topRatedState: RequestState.loading,
          ),
          TvState.initial().copyWith(
              topRatedState: RequestState.empty,
              message: 'Top rated tv series is empty'),
        ],
      );
    });

    group('error', () {
      blocTest<TvBloc, TvState>(
        'should emit [Loading, Error] tv when data is gotten unsuccessful',
        build: () {
          when(mockTvSeriesUseCase.getTopRatedTv()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvBloc;
        },
        act: (bloc) => bloc.add(TopRatedTvEvent()),
        verify: (bloc) {
          verify(mockTvSeriesUseCase.getTopRatedTv());
        },
        expect: () => <TvState>[
          TvState.initial().copyWith(
            topRatedState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            topRatedState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });

  group('detail movie', () {
    group('success', () {
      blocTest<TvBloc, TvState>(
        'should emit [Loading, Success] detail tv when data is gotten successfully',
        build: () {
          when(mockTvSeriesUseCase.getTvDetail(tId))
              .thenAnswer((_) async => const Right(tSeriesDetail));
          when(mockTvSeriesUseCase.getTvRecommendations(tId))
              .thenAnswer((_) async => Right(tSeriesList));

          return tvBloc;
        },
        act: (bloc) => bloc.add(const DetailTvEvent(tId)),
        verify: (bloc) => verify(mockTvSeriesUseCase.getTvDetail(tId)),
        expect: () => [
          TvState.initial().copyWith(
            detailState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
          ),
          TvState.initial().copyWith(
            recommendationState: RequestState.loading,
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
          ),
          TvState.initial().copyWith(
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
            recommendationState: RequestState.success,
            recommendationList: tSeriesList,
          ),
        ],
      );

      blocTest<TvBloc, TvState>(
        'should emit [Loading, Empty] recommendation in detail tv when data is gotten successfully',
        build: () {
          when(mockTvSeriesUseCase.getTvDetail(tId))
              .thenAnswer((_) async => const Right(tSeriesDetail));
          when(mockTvSeriesUseCase.getTvRecommendations(tId))
              .thenAnswer((_) async => const Right([]));

          return tvBloc;
        },
        act: (bloc) => bloc.add(const DetailTvEvent(tId)),
        verify: (bloc) => verify(mockTvSeriesUseCase.getTvDetail(tId)),
        expect: () => [
          TvState.initial().copyWith(
            detailState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
          ),
          TvState.initial().copyWith(
            recommendationState: RequestState.loading,
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
          ),
          TvState.initial().copyWith(
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
            recommendationState: RequestState.empty,
            message: 'Recommendation tv series is empty',
          ),
        ],
      );
    });

    group('error', () {
      blocTest<TvBloc, TvState>(
        'should emit [Loading, Error] in detail tv when data is gotten unsuccessful',
        build: () {
          when(mockTvSeriesUseCase.getTvDetail(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          when(mockTvSeriesUseCase.getTvRecommendations(tId))
              .thenAnswer((_) async => Right(tSeriesList));

          return tvBloc;
        },
        act: (bloc) => bloc.add(const DetailTvEvent(tId)),
        verify: (bloc) => verify(mockTvSeriesUseCase.getTvDetail(tId)),
        expect: () => [
          TvState.initial().copyWith(
            detailState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            detailState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );

      blocTest<TvBloc, TvState>(
        'should emit [Loading, Error] recommendation in detail tv when data is gotten unsuccessful',
        build: () {
          when(mockTvSeriesUseCase.getTvDetail(tId))
              .thenAnswer((_) async => const Right(tSeriesDetail));
          when(mockTvSeriesUseCase.getTvRecommendations(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvBloc;
        },
        act: (bloc) => bloc.add(const DetailTvEvent(tId)),
        verify: (bloc) => verify(mockTvSeriesUseCase.getTvDetail(tId)),
        expect: () => [
          TvState.initial().copyWith(
            detailState: RequestState.loading,
          ),
          TvState.initial().copyWith(
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
          ),
          TvState.initial().copyWith(
            recommendationState: RequestState.loading,
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
          ),
          TvState.initial().copyWith(
            detailState: RequestState.success,
            detailTv: tSeriesDetail,
            recommendationState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });

  group('watchlist tv', () {
    group('fetch watchlist tv', () {
      group('success', () {
        blocTest<TvBloc, TvState>(
          'should emit [Loading, Success] Watchlist when data is gotten successfully',
          build: () {
            when(mockTvSeriesUseCase.getWatchlistTv())
                .thenAnswer((_) async => Right(tSeriesList));

            return tvBloc;
          },
          act: (bloc) => bloc.add(WatchlistTvEvent()),
          verify: (bloc) => verify(mockTvSeriesUseCase.getWatchlistTv()),
          expect: () => <TvState>[
            TvState.initial().copyWith(
              watchlistState: RequestState.loading,
            ),
            TvState.initial().copyWith(
              watchlistState: RequestState.success,
              watchlistList: tSeriesList,
            ),
          ],
        );

        blocTest<TvBloc, TvState>(
          'should emit [Loading, Empty] Watchlist when data is gotten successfully',
          build: () {
            when(mockTvSeriesUseCase.getWatchlistTv())
                .thenAnswer((_) async => const Right([]));

            return tvBloc;
          },
          act: (bloc) => bloc.add(WatchlistTvEvent()),
          verify: (bloc) => verify(mockTvSeriesUseCase.getWatchlistTv()),
          expect: () => <TvState>[
            TvState.initial().copyWith(
              watchlistState: RequestState.loading,
            ),
            TvState.initial().copyWith(
              watchlistState: RequestState.empty,
              message: 'Watchlist tv series is empty',
            ),
          ],
        );
      });

      group('error', () {
        blocTest<TvBloc, TvState>(
          'should emit [Loading, Error] tv when data is gotten unsuccessful',
          build: () {
            when(mockTvSeriesUseCase.getWatchlistTv()).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));

            return tvBloc;
          },
          act: (bloc) => bloc.add(WatchlistTvEvent()),
          verify: (bloc) {
            verify(mockTvSeriesUseCase.getWatchlistTv());
          },
          expect: () => <TvState>[
            TvState.initial().copyWith(
              watchlistState: RequestState.loading,
            ),
            TvState.initial().copyWith(
              watchlistState: RequestState.error,
              message: 'Server Failure',
            ),
          ],
        );
      });
    });

    group('save watchlist tv', () {
      group('success', () {
        blocTest<TvBloc, TvState>(
          'should get watchlist status when function is called',
          build: () {
            when(mockTvSeriesUseCase.isAddedToWatchlist(tId))
                .thenAnswer((_) async => true);

            return tvBloc;
          },
          act: (bloc) => bloc.add(const WatchlistStatusTvEvent(tId)),
          verify: (bloc) => verify(mockTvSeriesUseCase.isAddedToWatchlist(tId)),
          expect: () => <TvState>[
            TvState.initial().copyWith(
              watchlistStatus: true,
            ),
          ],
        );

        blocTest<TvBloc, TvState>(
          'should save data watchlist when add data success',
          build: () {
            when(mockTvSeriesUseCase.saveWatchlistTv(tSeriesDetail))
                .thenAnswer((_) async => const Right(watchlistAddSuccess));
            when(mockTvSeriesUseCase.isAddedToWatchlist(tId))
                .thenAnswer((_) async => true);

            return tvBloc;
          },
          act: (bloc) => bloc.add(const SaveWatchlistTvEvent(tSeriesDetail)),
          verify: (bloc) =>
              verify(mockTvSeriesUseCase.saveWatchlistTv(tSeriesDetail)),
          expect: () => <TvState>[
            TvState.initial().copyWith(
              message: watchlistAddSuccess,
            ),
            TvState.initial().copyWith(
              watchlistStatus: true,
            ),
          ],
        );

        blocTest<TvBloc, TvState>(
          'should remove data watchlist when remove data success',
          build: () {
            when(mockTvSeriesUseCase.removeWatchlistTv(tSeriesDetail))
                .thenAnswer((_) async => const Right(watchlistAddSuccess));
            when(mockTvSeriesUseCase.isAddedToWatchlist(tId))
                .thenAnswer((_) async => false);

            return tvBloc;
          },
          act: (bloc) => bloc.add(const RemoveWatchlistTvEvent(tSeriesDetail)),
          verify: (bloc) =>
              verify(mockTvSeriesUseCase.removeWatchlistTv(tSeriesDetail)),
          expect: () => <TvState>[
            TvState.initial().copyWith(
              message: watchlistAddSuccess,
            ),
            TvState.initial().copyWith(
              watchlistStatus: false,
            ),
          ],
        );
      });

      group('error', () {
        blocTest<TvBloc, TvState>(
          'should update status watchlist when add data failed',
          build: () {
            when(mockTvSeriesUseCase.saveWatchlistTv(tSeriesDetail))
                .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
            when(mockTvSeriesUseCase.isAddedToWatchlist(tId))
                .thenAnswer((_) async => false);

            return tvBloc;
          },
          act: (bloc) => bloc.add(const SaveWatchlistTvEvent(tSeriesDetail)),
          verify: (bloc) =>
              verify(mockTvSeriesUseCase.saveWatchlistTv(tSeriesDetail)),
          expect: () => <TvState>[
            TvState.initial().copyWith(
              message: 'Failed',
            ),
            TvState.initial().copyWith(
              watchlistStatus: false,
            ),
          ],
        );

        blocTest<TvBloc, TvState>(
          'should update status watchlist when remove data failed',
          build: () {
            when(mockTvSeriesUseCase.removeWatchlistTv(tSeriesDetail))
                .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
            when(mockTvSeriesUseCase.isAddedToWatchlist(tId))
                .thenAnswer((_) async => false);

            return tvBloc;
          },
          act: (bloc) => bloc.add(const RemoveWatchlistTvEvent(tSeriesDetail)),
          verify: (bloc) =>
              verify(mockTvSeriesUseCase.removeWatchlistTv(tSeriesDetail)),
          expect: () => <TvState>[
            TvState.initial().copyWith(
              message: 'Failed',
            ),
            TvState.initial().copyWith(
              watchlistStatus: false,
            ),
          ],
        );
      });
    });
  });
}
