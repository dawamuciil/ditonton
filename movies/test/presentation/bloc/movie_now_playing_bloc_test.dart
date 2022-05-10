import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/presentation/bloc/now_playing_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = NowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('initial should be Empty', () {
    expect(movieNowPlayingBloc.state, NowPlayingEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<NowPlayingBloc, NowPlayingState>(
      'Should emit [MovieNowPlayingLoading, MovieNowPlayingHasData] when get now playing movie data is successful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlaying()),
      expect: () => [
        NowPlayingLoading(),
        NowPlayingHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingBloc, NowPlayingState>(
      'Should emit [MovieNowPlayingLoading, MovieNowPlayingError] when get now playing movie data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlaying()),
      expect: () => [
        NowPlayingLoading(),
        NowPlayingError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
