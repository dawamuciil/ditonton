import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchBloc;
  late MockSearchMovies mockSearch;

  setUp(() {
    mockSearch = MockSearchMovies();
    searchBloc = SearchMovieBloc(mockSearch);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchMovieEmpty());
  });

  blocTest<SearchMovieBloc, SearchMovieState>(
    'should emit [Loading, HasData] Movies when data is gotten successfully',
    build: () {
      when(mockSearch.execute(tQueryMovie))
          .thenAnswer((_) async => Right(tMovieList));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryMovieChanged(tQueryMovie)),
    wait: const Duration(milliseconds: 500),
    expect: () => <SearchMovieState>[
      SearchMovieLoading(),
      SearchMovieHasData(tMovieList)
    ],
    verify: (bloc) {
      verify(mockSearch.execute(tQueryMovie));
    },
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
    'should emit [Loading, Error] Movies when get search is unsuccessful',
    build: () {
      when(mockSearch.execute(tQueryMovie))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryMovieChanged(tQueryMovie)),
    wait: const Duration(milliseconds: 500),
    expect: () => <SearchMovieState>[
      SearchMovieLoading(),
      const SearchMovieError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockSearch.execute(tQueryMovie));
    },
  );
}
