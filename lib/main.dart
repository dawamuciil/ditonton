import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = await httpClient;
  di.initial();
  di.locator.registerLazySingleton<IOClient>(
    () => IOClient(client),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(
          child: CustomDrawer(
            content: HomeMoviePage(),
          ),
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case DETAIL_MOVIES_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case HOME_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => HomeTvPage());
            case ON_AIRING_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => OnAiringTvPage());
            case POPULAR_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TOP_RATED_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case DETAIL_TV_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailTvPage(id: id),
                settings: settings,
              );
            case SEASON_TV_ROUTE:
              final args = settings.arguments as SeasonTvPageArguments;
              return MaterialPageRoute(
                builder: (_) => SeasonTvPage(args.title, args.seasons),
                settings: settings,
              );
            case SEARCH_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WATCHLIST_ROUTE:
              return CupertinoPageRoute(builder: (_) => WatchlistPage());
            case ABOUT_ROUTE:
              return CupertinoPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
