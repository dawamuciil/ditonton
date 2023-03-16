import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/io_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final IOClient client;

  MovieRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final res = await client.get(Uri.parse(GET_NOW_PLAYING_MOVIE));

    if (res.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(res.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final res = await client.get(Uri.parse('$GET_DETAIL_MOVIE/$id?$API_KEY'));

    if (res.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final res = await client
        .get(Uri.parse('$GET_DETAIL_MOVIE/$id/$GET_RECOMMENDED_MOVIE'));

    if (res.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(res.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final res = await client.get(Uri.parse(GET_POPULAR_MOVIE));

    if (res.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(res.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final res = await client.get(Uri.parse(GET_TOP_RATED_MOVIE));

    if (res.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(res.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final res = await client.get(Uri.parse(GET_SEARCH_MOVIE + query));

    if (res.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(res.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
