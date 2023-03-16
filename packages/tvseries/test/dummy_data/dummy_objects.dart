import 'package:core/core.dart';

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
final tSeasonList = <Season>[tSeason];
