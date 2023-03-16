import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = SearchTv(mockTvRepository);
  });

  group('data from api', () {
    test('should get list of search tv from the repository', () async {
      when(mockTvRepository.searchTv(tQueryTv))
          .thenAnswer((_) async => Right(tSeries));

      final result = await useCase.execute(tQueryTv);
      expect(result, Right(tSeries));
    });
  });
}
