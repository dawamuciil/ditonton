import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_shows/domain/entities/tv_detail.dart';
import 'package:tv_shows/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}
