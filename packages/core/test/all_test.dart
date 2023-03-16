import 'data/datasources/movie_local_data_source_test.dart' as movie_local;
import 'data/datasources/movie_remote_data_source_test.dart' as movie_remote;
import 'data/datasources/tv_local_data_source_test.dart' as tv_local;
import 'data/datasources/tv_remote_data_source_test.dart' as tv_remote;
import 'data/models/genre_model_test.dart' as genre_model;
import 'data/models/movie_model_test.dart' as movie_model;
import 'data/models/movie_response_test.dart' as movie_response;
import 'data/models/season_model_test.dart' as season_model;
import 'data/models/tv_model_test.dart' as tv_model;
import 'data/models/tv_response_model_test.dart' as tv_response;
import 'data/repositories/movie_repository_impl_test.dart' as movie_repo;
import 'data/repositories/tv_repository_impl_test.dart' as tv_repo;
import 'presentation/widgets/sub_heading_test.dart' as sub_heading;
import 'style/text_style.dart' as text_style;

void main() {
  // datasource
  movie_local.main();
  movie_remote.main();
  tv_local.main();
  tv_remote.main();

  //models
  genre_model.main();
  movie_model.main();
  movie_response.main();
  season_model.main();
  tv_model.main();
  tv_response.main();

  // repositories
  movie_repo.main();
  tv_repo.main();

  // widgets
  sub_heading.main();

  // style
  text_style.main();
}
