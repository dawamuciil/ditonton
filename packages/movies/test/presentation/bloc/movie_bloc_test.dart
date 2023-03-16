import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetNowPlayingMovies mockNowPlayingMovies;
  late MockGetPopularMovies mockPopularMovies;
  late MockGetTopRatedMovies mockTopRatedMovies;
  late MockGetMovieDetail mockDetailMovies;
  late MockGetMovieRecommendations mockRecommendationMovies;
  late MockGetWatchlistMovies mockWatchlistMovies;
  late MockGetWatchListStatus mockWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MovieBloc movieBloc;

  setUp(() {
    mockNowPlayingMovies = MockGetNowPlayingMovies();
    mockPopularMovies = MockGetPopularMovies();
    mockTopRatedMovies = MockGetTopRatedMovies();
    mockDetailMovies = MockGetMovieDetail();
    mockRecommendationMovies = MockGetMovieRecommendations();
    mockWatchlistMovies = MockGetWatchlistMovies();
    mockWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieBloc = MovieBloc(
      playingMovies: mockNowPlayingMovies,
      popularMovies: mockPopularMovies,
      topRatedMovies: mockTopRatedMovies,
      detailMovies: mockDetailMovies,
      recommendationMovies: mockRecommendationMovies,
      watchlistMovies: mockWatchlistMovies,
      watchlistStatus: mockWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  test('initial state should be null or empty', () {
    expect(movieBloc.state, MovieState.initial());
  });

  group('now playing movies', () {
    group('success', () {
      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Success] Movies when data is gotten successfully',
        build: () {
          when(mockNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));

          return movieBloc;
        },
        act: (bloc) => bloc.add(NowPlayingEvent()),
        verify: (bloc) {
          verify(mockNowPlayingMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            nowPlayingState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            nowPlayingState: RequestState.success,
            nowPlayingList: testMovieList,
          ),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Empty] Movies when data is gotten successfully',
        build: () {
          when(mockNowPlayingMovies.execute())
              .thenAnswer((_) async => const Right([]));

          return movieBloc;
        },
        act: (bloc) => bloc.add(NowPlayingEvent()),
        verify: (bloc) {
          verify(mockNowPlayingMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            nowPlayingState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
              nowPlayingState: RequestState.empty,
              message: 'Now playing movie is empty'),
        ],
      );
    });

    group('error', () {
      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Error] Movies when data is gotten unsuccessful',
        build: () {
          when(mockNowPlayingMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieBloc;
        },
        act: (bloc) => bloc.add(NowPlayingEvent()),
        verify: (bloc) {
          verify(mockNowPlayingMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            nowPlayingState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            nowPlayingState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });

  group('popular movies', () {
    group('success', () {
      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Success] Movies when data is gotten successfully',
        build: () {
          when(mockPopularMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));

          return movieBloc;
        },
        act: (bloc) => bloc.add(PopularEvent()),
        verify: (bloc) {
          verify(mockPopularMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            popularState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            popularState: RequestState.success,
            popularList: testMovieList,
          ),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Empty] Movies when data is gotten successfully',
        build: () {
          when(mockPopularMovies.execute())
              .thenAnswer((_) async => const Right([]));

          return movieBloc;
        },
        act: (bloc) => bloc.add(PopularEvent()),
        verify: (bloc) {
          verify(mockPopularMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            popularState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
              popularState: RequestState.empty,
              message: 'Popular movie is empty'),
        ],
      );
    });

    group('error', () {
      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Error] Movies when data is gotten unsuccessful',
        build: () {
          when(mockPopularMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieBloc;
        },
        act: (bloc) => bloc.add(PopularEvent()),
        verify: (bloc) {
          verify(mockPopularMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            popularState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            popularState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });

  group('top rated movies', () {
    group('success', () {
      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Success] Movies when data is gotten successfully',
        build: () {
          when(mockTopRatedMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));

          return movieBloc;
        },
        act: (bloc) => bloc.add(TopRatedEvent()),
        verify: (bloc) {
          verify(mockTopRatedMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            topRatedState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            topRatedState: RequestState.success,
            topRatedList: testMovieList,
          ),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Empty] Movies when data is gotten successfully',
        build: () {
          when(mockTopRatedMovies.execute())
              .thenAnswer((_) async => const Right([]));

          return movieBloc;
        },
        act: (bloc) => bloc.add(TopRatedEvent()),
        verify: (bloc) {
          verify(mockTopRatedMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            topRatedState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
              topRatedState: RequestState.empty,
              message: 'Top rated movie is empty'),
        ],
      );
    });

    group('error', () {
      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Error] Movies when data is gotten unsuccessful',
        build: () {
          when(mockTopRatedMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieBloc;
        },
        act: (bloc) => bloc.add(TopRatedEvent()),
        verify: (bloc) {
          verify(mockTopRatedMovies.execute());
        },
        expect: () => <MovieState>[
          MovieState.initial().copyWith(
            topRatedState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            topRatedState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });

  group('detail movie', () {
    group('success', () {
      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Success] detail movies when data is gotten successfully',
        build: () {
          when(mockDetailMovies.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockRecommendationMovies.execute(tId))
              .thenAnswer((_) async => Right(testMovieList));

          return movieBloc;
        },
        act: (bloc) => bloc.add(const DetailMovieEvent(tId)),
        verify: (bloc) => verify(mockDetailMovies.execute(tId)),
        expect: () => [
          MovieState.initial().copyWith(
            detailState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
          ),
          MovieState.initial().copyWith(
            recommendationState: RequestState.loading,
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
          ),
          MovieState.initial().copyWith(
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
            recommendationState: RequestState.success,
            recommendationList: testMovieList,
          ),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Empty] recommendation in detail movies when data is gotten successfully',
        build: () {
          when(mockDetailMovies.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockRecommendationMovies.execute(tId))
              .thenAnswer((_) async => const Right([]));

          return movieBloc;
        },
        act: (bloc) => bloc.add(const DetailMovieEvent(tId)),
        verify: (bloc) => verify(mockDetailMovies.execute(tId)),
        expect: () => [
          MovieState.initial().copyWith(
            detailState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
          ),
          MovieState.initial().copyWith(
            recommendationState: RequestState.loading,
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
          ),
          MovieState.initial().copyWith(
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
            recommendationState: RequestState.empty,
            message: 'Recommendation movie is empty',
          ),
        ],
      );
    });

    group('error', () {
      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Error] in detail movies when data is gotten unsuccessful',
        build: () {
          when(mockDetailMovies.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          when(mockRecommendationMovies.execute(tId))
              .thenAnswer((_) async => Right(testMovieList));

          return movieBloc;
        },
        act: (bloc) => bloc.add(const DetailMovieEvent(tId)),
        verify: (bloc) => verify(mockDetailMovies.execute(tId)),
        expect: () => [
          MovieState.initial().copyWith(
            detailState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            detailState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'should emit [Loading, Error] recommendation in detail movies when data is gotten unsuccessful',
        build: () {
          when(mockDetailMovies.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockRecommendationMovies.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieBloc;
        },
        act: (bloc) => bloc.add(const DetailMovieEvent(tId)),
        verify: (bloc) => verify(mockDetailMovies.execute(tId)),
        expect: () => [
          MovieState.initial().copyWith(
            detailState: RequestState.loading,
          ),
          MovieState.initial().copyWith(
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
          ),
          MovieState.initial().copyWith(
            recommendationState: RequestState.loading,
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
          ),
          MovieState.initial().copyWith(
            detailState: RequestState.success,
            detailMovie: testMovieDetail,
            recommendationState: RequestState.error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });

  group('watchlist movies', () {
    group('fetch watchlist movies', () {
      group('success', () {
        blocTest<MovieBloc, MovieState>(
          'should emit [Loading, Success] Watchlist when data is gotten successfully',
          build: () {
            when(mockWatchlistMovies.execute())
                .thenAnswer((_) async => Right(testMovieList));

            return movieBloc;
          },
          act: (bloc) => bloc.add(WatchlistEvent()),
          verify: (bloc) => verify(mockWatchlistMovies.execute()),
          expect: () => <MovieState>[
            MovieState.initial().copyWith(
              watchlistState: RequestState.loading,
            ),
            MovieState.initial().copyWith(
              watchlistState: RequestState.success,
              watchlistList: testMovieList,
            ),
          ],
        );

        blocTest<MovieBloc, MovieState>(
          'should emit [Loading, Empty] Watchlist when data is gotten successfully',
          build: () {
            when(mockWatchlistMovies.execute())
                .thenAnswer((_) async => const Right([]));

            return movieBloc;
          },
          act: (bloc) => bloc.add(WatchlistEvent()),
          verify: (bloc) => verify(mockWatchlistMovies.execute()),
          expect: () => <MovieState>[
            MovieState.initial().copyWith(
              watchlistState: RequestState.loading,
            ),
            MovieState.initial().copyWith(
              watchlistState: RequestState.empty,
              message: 'Watchlist movie is empty',
            ),
          ],
        );
      });

      group('error', () {
        blocTest<MovieBloc, MovieState>(
          'should emit [Loading, Error] Movies when data is gotten unsuccessful',
          build: () {
            when(mockWatchlistMovies.execute()).thenAnswer(
                    (_) async => const Left(ServerFailure('Server Failure')));

            return movieBloc;
          },
          act: (bloc) => bloc.add(WatchlistEvent()),
          verify: (bloc) {
            verify(mockWatchlistMovies.execute());
          },
          expect: () => <MovieState>[
            MovieState.initial().copyWith(
              watchlistState: RequestState.loading,
            ),
            MovieState.initial().copyWith(
              watchlistState: RequestState.error,
              message: 'Server Failure',
            ),
          ],
        );
      });
    });

    group('save watchlist movies', () {
      group('success', () {
        blocTest<MovieBloc, MovieState>(
          'should get watchlist status when function is called',
          build: () {
            when(mockWatchlistStatus.execute(tId))
                .thenAnswer((_) async => true);

            return movieBloc;
          },
          act: (bloc) => bloc.add(const WatchlistStatusEvent(tId)),
          verify: (bloc) => verify(mockWatchlistStatus.execute(tId)),
          expect: () => <MovieState>[
            MovieState.initial().copyWith(
              watchlistStatus: true,
            ),
          ],
        );

        blocTest<MovieBloc, MovieState>(
          'should save data watchlist when add data success',
          build: () {
            when(mockSaveWatchlist.execute(testMovieDetail))
                .thenAnswer((_) async => const Right(watchlistAddSuccess));
            when(mockWatchlistStatus.execute(tId))
                .thenAnswer((_) async => true);

            return movieBloc;
          },
          act: (bloc) => bloc.add(const SaveWatchlistEvent(testMovieDetail)),
          verify: (bloc) => verify(mockSaveWatchlist.execute(testMovieDetail)),
          expect: () => <MovieState>[
            MovieState.initial().copyWith(
              message: watchlistAddSuccess,
            ),
            MovieState.initial().copyWith(
              watchlistStatus: true,
            ),
          ],
        );

        blocTest<MovieBloc, MovieState>(
          'should remove data watchlist when remove data success',
          build: () {
            when(mockRemoveWatchlist.execute(testMovieDetail))
                .thenAnswer((_) async => const Right(watchlistRemoveSuccess));
            when(mockWatchlistStatus.execute(tId))
                .thenAnswer((_) async => false);

            return movieBloc;
          },
          act: (bloc) => bloc.add(const RemoveWatchlistEvent(testMovieDetail)),
          verify: (bloc) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
          expect: () => <MovieState>[
            MovieState.initial().copyWith(
              message: watchlistRemoveSuccess,
            ),
            MovieState.initial().copyWith(
              watchlistStatus: false,
            ),
          ],
        );
      });

      group('error', () {
        blocTest<MovieBloc, MovieState>(
          'should update data watchlist when add data failed',
          build: () {
            when(mockSaveWatchlist.execute(testMovieDetail))
                .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
            when(mockWatchlistStatus.execute(tId))
                .thenAnswer((_) async => false);

            return movieBloc;
          },
          act: (bloc) => bloc.add(const SaveWatchlistEvent(testMovieDetail)),
          verify: (bloc) => verify(mockSaveWatchlist.execute(testMovieDetail)),
          expect: () => <MovieState>[
            MovieState.initial().copyWith(
              message: 'Failed',
            ),
            MovieState.initial().copyWith(
              watchlistStatus: false,
            ),
          ],
        );

        blocTest<MovieBloc, MovieState>(
          'should update data watchlist when remove data failed',
          build: () {
            when(mockRemoveWatchlist.execute(testMovieDetail))
                .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
            when(mockWatchlistStatus.execute(tId))
                .thenAnswer((_) async => false);

            return movieBloc;
          },
          act: (bloc) => bloc.add(const RemoveWatchlistEvent(testMovieDetail)),
          verify: (bloc) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
          expect: () => <MovieState>[
            MovieState.initial().copyWith(
              message: 'Failed',
            ),
            MovieState.initial().copyWith(
              watchlistStatus: false,
            ),
          ],
        );
      });
    });
  });
}
