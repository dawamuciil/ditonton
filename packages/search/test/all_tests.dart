import 'domain/usecase/search_movies_test.dart'as search_movie;
import 'domain/usecase/search_tv_test.dart' as search_tv;
import 'presentation/bloc/movie/search_movie_bloc_test.dart' as search_movie_bloc;
import 'presentation/bloc/tvseries/search_tv_bloc_test.dart' as search_tv_bloc;

void main() {
  // usecase
  search_movie.main();
  search_tv.main();

  // bloc
  search_movie_bloc.main();
  search_tv_bloc.main();
}