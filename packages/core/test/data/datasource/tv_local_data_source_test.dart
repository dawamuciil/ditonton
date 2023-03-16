import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  const tId = 1;

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.insertWatchlistTv(testTvTable);
      expect(result, watchlistAddSuccess);
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());

      final call = dataSource.insertWatchlistTv(testTvTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.removeWatchlistTv(testTvTable);
      expect(result, watchlistRemoveSuccess);
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get tv Detail by id', () {
    test('should return TV Detail Table when data is found', () async {
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);

      final result = await dataSource.getTvById(tId);
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);

      final result = await dataSource.getTvById(tId);
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvTable from database', () async {
      when(mockDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);

      final result = await dataSource.getWatchlistTv();
      expect(result, [testTvTable]);
    });
  });
}
