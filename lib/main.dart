import 'package:about/about_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/utils/http_ssl_pinning.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendation_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie_bloc.dart';
import 'package:movies/presentation/bloc/search_bloc.dart';
import 'package:movies/presentation/bloc/movie_top_rated_bloc.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/search_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:tv_shows/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_now_playing_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_popular_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_recommendation_bloc.dart';
import 'package:tv_shows/presentation/bloc/search_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:tv_shows/presentation/pages/home_tv_page.dart';
import 'package:tv_shows/presentation/pages/popular_tv_page.dart';
import 'package:tv_shows/presentation/pages/search_page_tv.dart';
import 'package:tv_shows/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_shows/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
            case HomeMoviePage.routeName:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case HomeTvPage.routeName:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case PopularTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case SearchTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );

            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
