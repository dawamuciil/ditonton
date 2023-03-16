import 'package:core/core.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: 'backdropPath',
  genreIds: const [1, 2],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  releaseDate: '2023-01-01',
  title: 'title',
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: '2023-01-01',
  runtime: 120,
  title: 'title',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const tId = 1;
final testMovieList = [testMovie];