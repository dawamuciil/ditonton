import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvSeries>>> getOnAiringTv();

  Future<Either<Failure, List<TvSeries>>> getPopularTv();

  Future<Either<Failure, List<TvSeries>>> getTopRatedTv();

  Future<Either<Failure, TvSeriesDetail>> getTvDetail(int id);

  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id);

  Future<Either<Failure, List<TvSeries>>> searchTv(String query);

  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();

  Future<Either<Failure, String>> saveWatchlistTv(TvSeriesDetail tv);

  Future<Either<Failure, String>> removeWatchlistTv(TvSeriesDetail tv);

  Future<bool> isAddedToWatchlist(int id);
}
