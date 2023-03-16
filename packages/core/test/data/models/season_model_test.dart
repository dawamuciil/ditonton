import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonModel = SeasonModel(
    airDate: '2023-01-01',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
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

  test('should return a valid model from JSON', () async {
    final result = tSeasonModel.toJson();
    final expectedJsonMap = {
      "air_date": "2023-01-01",
      "episode_count": 1,
      "id": 1,
      "name": "name",
      "overview": "overview",
      "poster_path": "posterPath",
      "season_number": 1,
    };

    expect(result, expectedJsonMap);
  });

  test('should be a subclass of season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
