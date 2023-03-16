import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('on airing tv', () {
    test(("should check if device is online"), () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getOnAiringTv()).thenAnswer((_) async => []);

      await repository.getOnAiringTv();

      verify(mockNetworkInfo.isConnected);
    });

    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getOnAiringTv())
            .thenAnswer((_) async => tSeriesModelList);

        final result = await repository.getOnAiringTv();
        verify(mockRemoteDataSource.getOnAiringTv());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getOnAiringTv()).thenThrow(ServerException());

        final result = await repository.getOnAiringTv();
        verify(mockRemoteDataSource.getOnAiringTv());

        expect(result, equals(const Left(ServerFailure(serverFailure))));
      });

      test(
          'should return ssl failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnAiringTv())
            .thenThrow(const TlsException());
        // act
        final result = await repository.getOnAiringTv();
        // assert
        verify(mockRemoteDataSource.getOnAiringTv());
        expect(result, equals(const Left(SSLFailure(sslFailure))));
      });

      test(
          'should return format failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnAiringTv())
            .thenThrow(const FormatException());
        // act
        final result = await repository.getOnAiringTv();
        // assert
        verify(mockRemoteDataSource.getOnAiringTv());
        expect(result, equals(const Left(FormatFailure(dataFailure))));
      });
    });

    group("when device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return failed connection when device is offline', () async {
        when(mockRemoteDataSource.getOnAiringTv()).thenThrow(
            const ConnectionFailure('Failed to connect to the network'));

        final result = await repository.getOnAiringTv();
        verifyNever(mockRemoteDataSource.getOnAiringTv());

        expect(result,
            const Left(ConnectionFailure('Failed to connect to the network')));
      });
    });
  });

  group('popular tv', () {
    test(("should check if device is online"), () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularTv()).thenAnswer((_) async => []);

      await repository.getPopularTv();

      verify(mockNetworkInfo.isConnected);
    });

    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getPopularTv())
            .thenAnswer((_) async => tSeriesModelList);

        final result = await repository.getPopularTv();
        verify(mockRemoteDataSource.getPopularTv());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());

        final result = await repository.getPopularTv();
        verify(mockRemoteDataSource.getPopularTv());

        expect(result, equals(const Left(ServerFailure(serverFailure))));
      });

      test(
          'should return ssl failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTv())
            .thenThrow(const TlsException());
        // act
        final result = await repository.getPopularTv();
        // assert
        verify(mockRemoteDataSource.getPopularTv());
        expect(result, equals(const Left(SSLFailure(sslFailure))));
      });

      test(
          'should return format failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTv())
            .thenThrow(const FormatException());
        // act
        final result = await repository.getPopularTv();
        // assert
        verify(mockRemoteDataSource.getPopularTv());
        expect(result, equals(const Left(FormatFailure(dataFailure))));
      });
    });

    group("when device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return failed connection when device is offline', () async {
        when(mockRemoteDataSource.getPopularTv()).thenThrow(
            const ConnectionFailure('Failed to connect to the network'));

        final result = await repository.getPopularTv();
        verifyNever(mockRemoteDataSource.getPopularTv());

        expect(result,
            const Left(ConnectionFailure('Failed to connect to the network')));
      });
    });
  });

  group('top rated tv', () {
    test(("should check if device is online"), () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopRatedTv()).thenAnswer((_) async => []);

      await repository.getTopRatedTv();

      verify(mockNetworkInfo.isConnected);
    });

    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => tSeriesModelList);

        final result = await repository.getTopRatedTv();
        verify(mockRemoteDataSource.getTopRatedTv());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());

        final result = await repository.getTopRatedTv();
        verify(mockRemoteDataSource.getTopRatedTv());

        expect(result, equals(const Left(ServerFailure(serverFailure))));
      });

      test(
          'should return ssl failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTv())
            .thenThrow(const TlsException());
        // act
        final result = await repository.getTopRatedTv();
        // assert
        verify(mockRemoteDataSource.getTopRatedTv());
        expect(result, equals(const Left(SSLFailure(sslFailure))));
      });

      test(
          'should return format failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTv())
            .thenThrow(const FormatException());
        // act
        final result = await repository.getTopRatedTv();
        // assert
        verify(mockRemoteDataSource.getTopRatedTv());
        expect(result, equals(const Left(FormatFailure(dataFailure))));
      });
    });

    group("when device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return failed connection when device is offline', () async {
        when(mockRemoteDataSource.getTopRatedTv()).thenThrow(
            const ConnectionFailure('Failed to connect to the network'));

        final result = await repository.getTopRatedTv();
        verifyNever(mockRemoteDataSource.getTopRatedTv());

        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      });
    });
  });

  group('get detail tv', () {
    test(("should check if device is online"), () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tSeriesDetailModel);

      await repository.getTvDetail(tId);

      verify(mockNetworkInfo.isConnected);
    });

    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return tv data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenAnswer((_) async => tSeriesDetailModel);

        final result = await repository.getTvDetail(tId);
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(const Right(tSeriesDetail)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenThrow(ServerException());

        final result = await repository.getTvDetail(tId);
        verify(mockRemoteDataSource.getTvDetail(tId));

        expect(result, equals(const Left(ServerFailure(serverFailure))));
      });

      test(
          'should return ssl failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenThrow(const TlsException());
        // act
        final result = await repository.getTvDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(const Left(SSLFailure(sslFailure))));
      });

      test(
          'should return format failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenThrow(const FormatException());
        // act
        final result = await repository.getTvDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(const Left(FormatFailure(dataFailure))));
      });
    });

    group("when device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(
            const ConnectionFailure('Failed to connect to the network'));

        final result = await repository.getTvDetail(tId);

        verifyNever(mockRemoteDataSource.getTvDetail(tId));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      });
    });
  });

  group('get tv recommendations', () {
    test(("should check if device is online"), () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => []);

      await repository.getTvRecommendations(tId);

      verify(mockNetworkInfo.isConnected);
    });

    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getTvRecommendations(tId))
            .thenAnswer((_) async => tSeriesModelList);

        final result = await repository.getTvRecommendations(tId);
        verify(mockRemoteDataSource.getTvRecommendations(tId));

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getTvRecommendations(tId))
            .thenThrow(ServerException());

        final result = await repository.getTvRecommendations(tId);
        verify(mockRemoteDataSource.getTvRecommendations(tId));

        expect(result, equals(const Left(ServerFailure(serverFailure))));
      });

      test(
          'should return ssl failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(tId))
            .thenThrow(const TlsException());
        // act
        final result = await repository.getTvRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        expect(result, equals(const Left(SSLFailure(sslFailure))));
      });

      test(
          'should return format failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(tId))
            .thenThrow(const FormatException());
        // act
        final result = await repository.getTvRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        expect(result, equals(const Left(FormatFailure(dataFailure))));
      });
    });

    group("when device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return failed connection when device is offline', () async {
        when(mockRemoteDataSource.getTvRecommendations(tId)).thenThrow(
            const ConnectionFailure('Failed to connect to the network'));

        final result = await repository.getTvRecommendations(tId);
        verifyNever(mockRemoteDataSource.getTvRecommendations(tId));

        expect(result,
            const Left(ConnectionFailure('Failed to connect to the network')));
      });
    });
  });

  group('get tv search', () {
    test(("should check if device is online"), () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.searchTv(tQueryTv))
          .thenAnswer((_) async => tSeriesModelList);

      await repository.searchTv(tQueryTv);

      verify(mockNetworkInfo.isConnected);
    });

    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.searchTv(tQueryTv))
            .thenAnswer((_) async => tSeriesModelList);

        final result = await repository.searchTv(tQueryTv);
        verify(mockRemoteDataSource.searchTv(tQueryTv));

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.searchTv(tQueryTv))
            .thenThrow(ServerException());

        final result = await repository.searchTv(tQueryTv);
        verify(mockRemoteDataSource.searchTv(tQueryTv));

        expect(result, equals(const Left(ServerFailure(serverFailure))));
      });

      test(
          'should return ssl failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTv(tQueryTv))
            .thenThrow(const TlsException());
        // act
        final result = await repository.searchTv(tQueryTv);
        // assert
        verify(mockRemoteDataSource.searchTv(tQueryTv));
        expect(result, equals(const Left(SSLFailure(sslFailure))));
      });

      test(
          'should return format failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTv(tQueryTv))
            .thenThrow(const FormatException());
        // act
        final result = await repository.searchTv(tQueryTv);
        // assert
        verify(mockRemoteDataSource.searchTv(tQueryTv));
        expect(result, equals(const Left(FormatFailure(dataFailure))));
      });
    });

    group("when device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return failed connection when device is offline', () async {
        when(mockRemoteDataSource.searchTv(tQueryTv)).thenThrow(
            const ConnectionFailure('Failed to connect to the network'));

        final result = await repository.searchTv(tQueryTv);
        verifyNever(mockRemoteDataSource.searchTv(tQueryTv));

        expect(result,
            const Left(ConnectionFailure('Failed to connect to the network')));
      });
    });
  });

  group('get watchlist tv', () {
    test('should return list of tv series', () async {
      when(mockLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);

      final result = await repository.getWatchlistTv();
      final resultList = result.getOrElse(() => []);

      expect(resultList, [testWatchlistTv]);
    });
  });

  group('save watchlist tv', () {
    test('success message when saving successful', () async {
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => watchlistAddSuccess);

      final result = await repository.saveWatchlistTv(tSeriesDetail);
      expect(result, const Right(watchlistAddSuccess));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.saveWatchlistTv(tSeriesDetail);
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist tv', () {
    test('success message when remove successful', () async {
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => watchlistRemoveSuccess);

      final result = await repository.removeWatchlistTv(tSeriesDetail);
      expect(result, const Right(watchlistRemoveSuccess));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.removeWatchlistTv(tSeriesDetail);
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlist(tId);
      expect(result, false);
    });
  });
}
