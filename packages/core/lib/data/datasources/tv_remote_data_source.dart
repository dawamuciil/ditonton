import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/io_client.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getOnAiringTv();
  Future<List<TvModel>> getPopularTv();
  Future<List<TvModel>> getTopRatedTv();
  Future<TvDetailModel> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTv(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final IOClient client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getOnAiringTv() async {
    final res = await client.get(Uri.parse(GET_ON_AIRING_TV));

    if (res.statusCode == 200) {
      return TvResponse.fromJson(json.decode(res.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final res = await client.get(Uri.parse(GET_POPULAR_TV));

    if (res.statusCode == 200) {
      return TvResponse.fromJson(json.decode(res.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final res = await client.get(Uri.parse(GET_TOP_RATED_TV));

    if (res.statusCode == 200) {
      return TvResponse.fromJson(json.decode(res.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    final res = await client.get(Uri.parse('$GET_DETAIL_TV/$id?$API_KEY'));

    if (res.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final res =
        await client.get(Uri.parse('$GET_DETAIL_TV/$id/$GET_RECOMMENDED_TV'));

    if (res.statusCode == 200) {
      return TvResponse.fromJson(json.decode(res.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final res = await client.get(Uri.parse(GET_SEARCH_TV + query));

    if (res.statusCode == 200) {
      return TvResponse.fromJson(json.decode(res.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
