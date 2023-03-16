import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchBloc;
  late MockSearchTv mockSearch;

  setUp(() {
    mockSearch = MockSearchTv();
    searchBloc = SearchTvBloc(mockSearch);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchTvEmpty());
  });

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [Loading, HasData] TV Series when data is gotten successfully',
    build: () {
      when(mockSearch.execute(tQueryMovie))
          .thenAnswer((_) async => Right(tSeriesList));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTvChanged(tQueryMovie)),
    wait: const Duration(milliseconds: 500),
    expect: () => <SearchTvState>[
      SearchTvLoading(),
      SearchTvHasData(tSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearch.execute(tQueryMovie));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [Loading, Error] TV Series when get search is unsuccessful',
    build: () {
      when(mockSearch.execute(tQueryMovie))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTvChanged(tQueryMovie)),
    wait: const Duration(milliseconds: 500),
    expect: () => <SearchTvState>[
      SearchTvLoading(),
      const SearchTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearch.execute(tQueryMovie));
    },
  );
}
