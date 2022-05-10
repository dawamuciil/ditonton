import 'package:dartz/dartz.dart';
import 'package:tv_shows/domain/entities/tv.dart';
import 'package:tv_shows/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
