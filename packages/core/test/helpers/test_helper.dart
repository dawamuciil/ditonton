import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  MovieLocalDataSource,
  TvLocalDataSource,
  DatabaseHelper,
  NetworkInfo
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<IOClient>(as: #MockIoClient)
])
void main() {}
