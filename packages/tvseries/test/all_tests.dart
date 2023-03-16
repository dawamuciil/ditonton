import 'domain/usecases/tv_series_test.dart' as tv_series;
import './presentation/bloc/tv_bloc_test.dart' as tv_bloc;
import './presentation/pages/detail_tv_page_test.dart' as detail_page;
import './presentation/pages/home_tv_page_test.dart' as home_page;
import './presentation/pages/on_airing_tv_page_test.dart' as on_airing_page;
import './presentation/pages/popular_tv_page_test.dart' as popular_page;
import './presentation/pages/season_tv_page_test.dart' as season_page;
import './presentation/pages/top_rated_tv_page_test.dart' as top_rated_page;

void main() {
  // usecase
  tv_series.main();

  // bloc
  tv_bloc.main();

  // presentation
  home_page.main();
  detail_page.main();
  on_airing_page.main();
  popular_page.main();
  top_rated_page.main();
  season_page.main();
}
