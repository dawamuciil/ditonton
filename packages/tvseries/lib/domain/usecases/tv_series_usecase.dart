import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class TvSeriesUseCase {
  final TvRepository repo;

  TvSeriesUseCase(this.repo);

  Future<Either<Failure, List<TvSeries>>> getOnAiringTv() =>
      repo.getOnAiringTv();

  Future<Either<Failure, List<TvSeries>>> getPopularTv() => repo.getPopularTv();

  Future<Either<Failure, List<TvSeries>>> getTopRatedTv() =>
      repo.getTopRatedTv();

  Future<Either<Failure, TvSeriesDetail>> getTvDetail(int id) =>
      repo.getTvDetail(id);

  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id) =>
      repo.getTvRecommendations(id);

  Future<Either<Failure, List<TvSeries>>> searchTv(String query) =>
      repo.searchTv(query);

  Future<Either<Failure, List<TvSeries>>> getWatchlistTv() =>
      repo.getWatchlistTv();

  Future<Either<Failure, String>> saveWatchlistTv(TvSeriesDetail tv) =>
      repo.saveWatchlistTv(tv);

  Future<Either<Failure, String>> removeWatchlistTv(TvSeriesDetail tv) =>
      repo.removeWatchlistTv(tv);

  Future<bool> isAddedToWatchlist(int id) => repo.isAddedToWatchlist(id);
}
