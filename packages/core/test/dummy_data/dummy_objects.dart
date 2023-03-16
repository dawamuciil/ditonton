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

final testMovieList = [testMovie];

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

const tSeriesModel = TvModel(
  backdropPath: '/path.jpg',
  firstAirDate: "2023-01-01",
  genreIds: [1, 2, 3],
  id: 1,
  name: "Name",
  originalName: 'Original Name',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

const tId = 1;
const tQueryTv = 'The Last of Us';
const tSeriesDetailModel = TvDetailModel(
  adult: false,
  backdropPath: 'backdropPath',
  firstAirDate: '2023-01-01',
  genres: [
    GenreModel(
      id: 1,
      name: 'name',
    )
  ],
  homepage: 'homepage',
  id: 1,
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  seasons: [
    SeasonModel(
      airDate: '2023-01-01',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    )
  ],
  status: 'status',
  tagline: 'tagline',
  voteAverage: 1.0,
  voteCount: 1,
);

final tSeries = TvSeries(
  backdropPath: '/path.jpg',
  firstAirDate: "2023-01-01",
  genreIds: const [1, 2, 3],
  id: 1,
  name: "Name",
  originalName: 'Original Name',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

const tSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  firstAirDate: '2023-01-01',
  genres: [
    Genre(
      id: 1,
      name: 'name',
    )
  ],
  homepage: 'homepage',
  id: 1,
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  seasons: [
    Season(
      airDate: '2023-01-01',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    )
  ],
  status: 'status',
  tagline: 'tagline',
  voteAverage: 1.0,
  voteCount: 1,
);

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};

final testWatchlistTv = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const tSeason = Season(
  airDate: '2023-01-01',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

final tSeriesModelList = <TvModel>[tSeriesModel];
final tSeriesList = <TvSeries>[tSeries];
