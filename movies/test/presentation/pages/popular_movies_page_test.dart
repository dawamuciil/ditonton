import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/popular_movie_bloc.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMoviePopularBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

class MoviePopularEventFake extends Fake implements PopularMovieEvent {}

class MoviePopularStateFake extends Fake implements PopularMovieState {}

@GenerateMocks([PopularMovieBloc])
void main() {
  late MockMoviePopularBloc mockMoviePopularBloc;

  setUpAll(() {
    registerFallbackValue(MoviePopularEventFake());
    registerFallbackValue(MoviePopularStateFake());
  });

  setUp(() {
    mockMoviePopularBloc = MockMoviePopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: mockMoviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.state).thenReturn(PopularMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.state)
        .thenReturn(PopularMovieError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
