import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
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

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
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

  test('should return a valid model from JSON', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/movie.json'));
    final result = MovieModel.fromJson(jsonMap);

    expect(result, tMovieModel);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tMovieModel.toJson();
    final expectedJsonMap = {
      "adult": false,
      "backdrop_path": "backdropPath",
      "genre_ids": [1, 2, 3],
      "id": 1,
      "original_title": "originalTitle",
      "overview": "overview",
      "popularity": 1,
      "poster_path": "posterPath",
      "release_date": "releaseDate",
      "title": "title",
      "video": false,
      "vote_average": 1.0,
      "vote_count": 1
    };

    expect(result, expectedJsonMap);
  });

  test('should be a subclass of Movie entity', () {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });
}
