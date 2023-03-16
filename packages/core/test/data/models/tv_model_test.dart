import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

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

  test('should be a subclass of Tv Series entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
