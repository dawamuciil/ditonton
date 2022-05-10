import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'event/movie_top_rated_event.dart';
part 'state/movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(MovieTopRatedEmpty()) {
    on<FetchMovieTopRated>(
      (event, emit) async {
        emit(MovieTopRatedLoading());

        final topRatedResult = await _getTopRatedMovies.execute();

        topRatedResult.fold(
          (failure) {
            emit(MovieTopRatedError(failure.message));
          },
          (data) {
            emit(MovieTopRatedHasData(data));
          },
        );
      },
    );
  }
}
