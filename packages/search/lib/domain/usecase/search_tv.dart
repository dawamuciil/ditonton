import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SearchTv {
  final TvRepository repo;

  SearchTv(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute(String query) =>
      repo.searchTv(query);
}
