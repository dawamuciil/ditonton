import 'package:core/core.dart';

const tId = 1;
const tQueryMovie = 'Spider-Man';
const tQueryTv = 'The Last of Us';

final tMovieList = <Movie>[tMovieModel];
final tMovie = <Movie>[];
final tSeriesList = <TvSeries>[tSeriesModel];
final tSeries = <TvSeries>[];

final tMovieModel = Movie(
  adult: false,
  backdropPath: 'backdropPath',
  genreIds: const [1, 2],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  title: 'title',
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);

final tSeriesModel = TvSeries(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: const [1, 2],
  id: 1,
  name: 'name',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1.0,
  voteCount: 1,
);
