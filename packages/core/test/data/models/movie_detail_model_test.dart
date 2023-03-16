import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: "Name",
  );

  const tGenre = Genre(
    id: 1,
    name: "Name",
  );

  const tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdrop_path',
    budget: 1,
    genres: [tGenreModel],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdb_id',
    originalLanguage: 'original_language',
    originalTitle: 'original_title',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'poster_path',
    releaseDate: 'release_date',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdrop_path',
    genres: [tGenre],
    id: 1,
    originalTitle: 'original_title',
    overview: 'overview',
    posterPath: 'poster_path',
    releaseDate: 'release_date',
    runtime: 1,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should return a valid model from JSON', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/movie_detail_response.json'));
    final result = MovieDetailResponse.fromJson(jsonMap);

    expect(result, tMovieDetailModel);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tMovieDetailModel.toJson();
    final expectedJsonMap = {
      "adult": false,
      "backdrop_path": "backdrop_path",
      "budget": 1,
      "genres": [
        {"id": 1, "name": "Name"}
      ],
      "homepage": "homepage",
      "id": 1,
      "imdb_id": "imdb_id",
      "original_language": "original_language",
      "original_title": "original_title",
      "overview": "overview",
      "popularity": 1.0,
      "poster_path": "poster_path",
      "release_date": "release_date",
      "revenue": 1,
      "runtime": 1,
      "status": "status",
      "tagline": "tagline",
      "title": "title",
      "video": false,
      "vote_average": 1.0,
      "vote_count": 1
    };

    expect(result, expectedJsonMap);
  });

  test('should be a subclass of genre entity', () async {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });
}
