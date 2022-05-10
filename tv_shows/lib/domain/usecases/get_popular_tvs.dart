import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_shows/domain/entities/tv.dart';
import 'package:tv_shows/domain/repositories/tv_repository.dart';

class GetPopularTv {
  final TvRepository repository;

  GetPopularTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
