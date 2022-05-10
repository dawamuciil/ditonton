import 'package:core/utils/http_ssl_pinning.dart';
import 'package:movies/data/datasources/db/database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/remove_watchlist_movies.dart';
import 'package:movies/domain/usecases/save_watchlist_movies.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendation_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie_bloc.dart';
import 'package:movies/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/presentation/bloc/movie_top_rated_bloc.dart';
import 'package:tv_shows/data/datasources/db/database_helper_tvs.dart';
import 'package:tv_shows/data/datasources/tv_local_data_source.dart';
import 'package:tv_shows/data/datasources/tv_remote_data_source.dart';
import 'package:tv_shows/data/repositories/tv_repository_impl.dart';
import 'package:tv_shows/domain/repositories/tv_repository.dart';
import 'package:tv_shows/domain/usecases/get_now_playing_tvs.dart';
import 'package:tv_shows/domain/usecases/get_popular_tvs.dart';
import 'package:tv_shows/domain/usecases/get_top_rated_tvs.dart';
import 'package:tv_shows/domain/usecases/get_tv_detail.dart';
import 'package:tv_shows/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv_shows/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv_shows/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_shows/domain/usecases/save_tv_watchlist.dart';
import 'package:tv_shows/domain/usecases/search_tvs.dart';
import 'package:tv_shows/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_now_playing_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_popular_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_recommendation_bloc.dart';
import 'package:tv_shows/presentation/bloc/search_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvTopRatedBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListMovieStatus(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTvs>(() => DatabaseHelperTvs());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
