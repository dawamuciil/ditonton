import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenre = Genre(
    id: 1,
    name: "Name",
  );

  const tMovieTable = MovieTable(
    id: 1,
    title: "title",
    posterPath: "posterPath",
    overview: "overview",
  );

  final tMovieWatchlist = Movie.watchlist(
    id: 1,
    overview: "overview",
    posterPath: "posterPath",
    title: "title",
  );

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [tGenre],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMapMovie = {
    "id": 1,
    "title": "title",
    "posterPath": "posterPath",
    "overview": "overview"
  };

  test('should return a valid model from Entity', () async {
    final result = MovieTable.fromEntity(tMovieDetail);
    expect(result, tMovieTable);
  });

  test('should return a valid model from Map', () async {
    final Map<String, dynamic> jsonMap = tMapMovie;
    final result = MovieTable.fromMap(jsonMap);

    expect(result, tMovieTable);
  });

  test('should return a valid model from DTO', () async {
    final result = MovieTable.fromDTO(tMovieModel);
    expect(result, tMovieTable);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tMovieTable.toJson();
    final expectedJsonMap = {
      "id": 1,
      "title": "title",
      "posterPath": "posterPath",
      "overview": "overview"
    };

    expect(result, expectedJsonMap);
  });

  test('should be a subclass of genre entity', () async {
    final result = tMovieTable.toEntity();
    expect(result, tMovieWatchlist);
  });
}
