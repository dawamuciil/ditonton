import 'package:dartz/dartz.dart';
import 'package:tv_shows/domain/entities/tv.dart';
import 'package:tv_shows/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';

class GetWatchlistTv {
  final TvRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
