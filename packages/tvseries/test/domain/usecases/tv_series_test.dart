import 'package:core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesUseCase useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = TvSeriesUseCase(mockTvRepository);
  });

  group('data from api', () {
    test('should get list of tv from the repository', () async {
      when(mockTvRepository.getOnAiringTv())
          .thenAnswer((_) async => Right(tSeriesList));

      final result = await useCase.getOnAiringTv();
      expect(result, Right(tSeriesList));
    });

    test('should get list of popular tv from the repository', () async {
      when(mockTvRepository.getPopularTv())
          .thenAnswer((_) async => Right(tSeriesList));

      final result = await useCase.getPopularTv();
      expect(result, Right(tSeriesList));
    });

    test('should get list of top rated tv from the repository', () async {
      when(mockTvRepository.getTopRatedTv())
          .thenAnswer((_) async => Right(tSeriesList));

      final result = await useCase.getTopRatedTv();
      expect(result, Right(tSeriesList));
    });

    test('should get tv detail from the repository', () async {
      when(mockTvRepository.getTvDetail(tId))
          .thenAnswer((_) async => const Right(tSeriesDetail));

      final result = await useCase.getTvDetail(tId);
      expect(result, const Right(tSeriesDetail));
    });

    test('should get list of recommendation tv from the repository', () async {
      when(mockTvRepository.getTvRecommendations(tId))
          .thenAnswer((_) async => Right(tSeriesList));

      final result = await useCase.getTvRecommendations(tId);
      expect(result, Right(tSeriesList));
    });

    test('should get list of search tv from the repository', () async {
      when(mockTvRepository.searchTv(tQueryTv))
          .thenAnswer((_) async => Right(tSeriesList));

      final result = await useCase.searchTv(tQueryTv);
      expect(result, Right(tSeriesList));
    });
  });

  group('data from local db', () {
    test('should get list of watchlist tv from the repository', () async {
      when(mockTvRepository.getWatchlistTv())
          .thenAnswer((_) async => Right(tSeriesList));

      final result = await useCase.getWatchlistTv();
      expect(result, Right(tSeriesList));
    });

    test('should save watchlist tv to the repository', () async {
      when(mockTvRepository.saveWatchlistTv(tSeriesDetail))
          .thenAnswer((_) async => const Right(watchlistAddSuccess));

      final result = await useCase.saveWatchlistTv(tSeriesDetail);

      verify(mockTvRepository.saveWatchlistTv(tSeriesDetail));
      expect(result, const Right(watchlistAddSuccess));
    });

    test('should remove watchlist tv to the repository', () async {
      when(mockTvRepository.removeWatchlistTv(tSeriesDetail))
          .thenAnswer((_) async => const Right(watchlistRemoveSuccess));

      final result = await useCase.removeWatchlistTv(tSeriesDetail);

      verify(mockTvRepository.removeWatchlistTv(tSeriesDetail));
      expect(result, const Right(watchlistRemoveSuccess));
    });

    test('should get watchlist tv status from repository', () async {
      when(mockTvRepository.isAddedToWatchlist(tId))
          .thenAnswer((_) async => true);

      final result = await useCase.isAddedToWatchlist(tId);
      expect(result, true);
    });
  });
}
