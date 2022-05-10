import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/presentation/bloc/popular_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('initial should be Empty', () {
    expect(moviePopularBloc.state, PopularMovieEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [MoviePopularLoading, MoviePopularHasData] when get popular movie data is successful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [MoviePopularLoading, MoviePopularError] when get popular movie data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
