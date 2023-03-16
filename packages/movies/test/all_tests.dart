import 'domain/usecases/get_movie_detail_test.dart' as get_movie_detail;
import './domain/usecases/get_movie_recommendations_test.dart'
    as get_movie_recommended;
import './domain/usecases/get_now_playing_movies_test.dart'
    as get_now_playing_movie;
import './domain/usecases/get_popular_movies_test.dart' as get_popular_movie;
import './domain/usecases/get_top_rated_movies_test.dart' as get_top_rated;
import './domain/usecases/get_watchlist_movies_test.dart'
    as get_watchlist_movies;
import './domain/usecases/get_watchlist_status_test.dart'
    as get_watchlist_status;
import './domain/usecases/remove_watchlist_test.dart' as remove_watchlist;
import 'domain/usecases/save_watchlist_test.dart' as save_watchlist;
import 'presentation/pages/movie_detail_page_test.dart' as movie_detail_page;
import 'presentation/pages/popular_movie_page_test.dart'
    as popular_movie_page;
import 'presentation/pages/top_rated_movie_page_test.dart' as top_rated_movie;
import 'presentation/bloc/movie_bloc_test.dart' as movie_bloc;

import 'presentation/pages/home_movie_page_test.dart' as home_movie;

void main() {
  // useCase
  get_movie_detail.main();
  get_movie_recommended.main();
  get_now_playing_movie.main();
  get_popular_movie.main();
  get_top_rated.main();
  get_watchlist_movies.main();
  get_watchlist_status.main();
  remove_watchlist.main();
  save_watchlist.main();

  // bloc
  movie_bloc.main();

  // presentation
  home_movie.main();
  movie_detail_page.main();
  popular_movie_page.main();
  top_rated_movie.main();
}
