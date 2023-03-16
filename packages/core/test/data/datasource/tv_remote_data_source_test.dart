import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvRemoteDataSourceImpl dataSource;
  late MockIoClient mockIoClient;

  setUp(() {
    mockIoClient = MockIoClient();
    dataSource = TvRemoteDataSourceImpl(client: mockIoClient);
  });

  group('get On Airing TV', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tvseries/on_airing.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      when(mockIoClient.get(Uri.parse(GET_ON_AIRING_TV))).thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/tvseries/on_airing.json'), 200));

      final result = await dataSource.getOnAiringTv();
      expect(result, equals(tvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIoClient.get(Uri.parse(GET_ON_AIRING_TV)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getOnAiringTv();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TV', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tvseries/popular.json')))
        .tvList;

    test('should return list of popular tv when response is success (200)',
        () async {
      when(mockIoClient.get(Uri.parse(GET_POPULAR_TV))).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tvseries/popular.json'), 200));

      final result = await dataSource.getPopularTv();
      expect(result, tvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIoClient.get(Uri.parse(GET_POPULAR_TV)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getPopularTv();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tvseries/top_rated.json')))
        .tvList;

    test('should return list of top rated tv when response code is 200 ',
        () async {
      when(mockIoClient.get(Uri.parse(GET_TOP_RATED_TV))).thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/tvseries/top_rated.json'), 200));

      final result = await dataSource.getTopRatedTv();
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIoClient.get(Uri.parse(GET_TOP_RATED_TV)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTopRatedTv();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    const tId = 1;
    final tvDetail = TvDetailModel.fromJson(
        json.decode(readJson('dummy_data/tvseries/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      when(mockIoClient.get(Uri.parse('$GET_DETAIL_TV/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries/tv_detail.json'), 200));

      final result = await dataSource.getTvDetail(tId);
      expect(result, equals(tvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIoClient.get(Uri.parse('$GET_DETAIL_TV/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTvDetail(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tvseries/recommendation.json')))
        .tvList;
    const tId = 1;

    test('should return list of TV Model when the response code is 200',
        () async {
      when(mockIoClient
              .get(Uri.parse('$GET_DETAIL_TV/$tId/$GET_RECOMMENDED_TV')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries/recommendation.json'), 200));

      final result = await dataSource.getTvRecommendations(tId);
      expect(result, equals(tvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIoClient
              .get(Uri.parse('$GET_DETAIL_TV/$tId/$GET_RECOMMENDED_TV')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTvRecommendations(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tvseries/search.json')))
        .tvList;
    const tQuery = 'The Last of Us';

    test('should return list of tv when response code is 200', () async {
      when(mockIoClient.get(Uri.parse(GET_SEARCH_TV + tQuery))).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/tvseries/search.json'), 200));

      final result = await dataSource.searchTv(tQuery);
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIoClient.get(Uri.parse(GET_SEARCH_TV + tQuery)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.searchTv(tQuery);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
