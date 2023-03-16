import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getOnAiringTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getOnAiringTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(serverFailure));
      } on TlsException {
        return const Left(SSLFailure(sslFailure));
      } on FormatException {
        return const Left(FormatFailure(dataFailure));
      }
    } else {
      return const Left(ConnectionFailure(connectionFailure));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(serverFailure));
      } on TlsException {
        return const Left(SSLFailure(sslFailure));
      } on FormatException {
        return const Left(FormatFailure(dataFailure));
      }
    } else {
      return const Left(ConnectionFailure(connectionFailure));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(serverFailure));
      } on TlsException {
        return const Left(SSLFailure(sslFailure));
      } on FormatException {
        return const Left(FormatFailure(dataFailure));
      }
    } else {
      return const Left(ConnectionFailure(connectionFailure));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvDetail(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvDetail(id);
        return Right(result.toEntity());
      } on ServerException {
        return const Left(ServerFailure(serverFailure));
      } on TlsException {
        return const Left(SSLFailure(sslFailure));
      } on FormatException {
        return const Left(FormatFailure(dataFailure));
      }
    } else {
      return const Left(ConnectionFailure(connectionFailure));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvRecommendations(id);
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(serverFailure));
      } on TlsException {
        return const Left(SSLFailure(sslFailure));
      } on FormatException {
        return const Left(FormatFailure(dataFailure));
      }
    } else {
      return const Left(ConnectionFailure(connectionFailure));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTv(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.searchTv(query);
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(serverFailure));
      } on TlsException {
        return const Left(SSLFailure(sslFailure));
      } on FormatException {
        return const Left(FormatFailure(dataFailure));
      }
    } else {
      return const Left(ConnectionFailure(connectionFailure));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvSeriesDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvSeriesDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
