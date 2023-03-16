import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingMovies();
        localDataSource.cacheNowPlayingMovies(
          result.map((movie) => MovieTable.fromDTO(movie)).toList(),
        );
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(serverFailure));
      } on TlsException {
        return const Left(SSLFailure(sslFailure));
      } on FormatException {
        return const Left(FormatFailure(dataFailure));
      }
    } else {
      try {
        final result = await localDataSource.getCacheNowPlayingMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getMovieDetail(id);
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
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getMovieRecommendations(id);
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
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularMovies();
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
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedMovies();
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
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.searchMovies(query);
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
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    try {
      final result =
          await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    try {
      final result =
          await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
