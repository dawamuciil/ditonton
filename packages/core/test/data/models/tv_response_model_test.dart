import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
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
  const tSeriesResponseModel = TvResponse(tvList: <TvModel>[tSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tvseries/on_airing.json'));
      final result = TvResponse.fromJson(jsonMap);

      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tSeriesResponseModel.toJson();
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2023-01-01",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "Name",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
