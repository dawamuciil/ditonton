import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  NetworkInfo
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
