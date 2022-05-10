import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/data/datasources/db/database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:tv_shows/data/datasources/db/database_helper_tvs.dart';
import 'package:tv_shows/data/datasources/tv_local_data_source.dart';
import 'package:tv_shows/data/datasources/tv_remote_data_source.dart';
import 'package:tv_shows/domain/repositories/tv_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelperTvs,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
