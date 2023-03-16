import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieBloc mockBloc;

  setUpAll(() {
    mockBloc = MockMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('now playing movies', () {
    testWidgets(
        'Now playing movies should display center progress bar when loading',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        nowPlayingState: RequestState.loading,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final centerFinder = find.byType(CircularProgressIndicator);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Now playing movies should display data listView when data is loaded',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        nowPlayingState: RequestState.success,
        nowPlayingList: testMovieList,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final listViewFinder = find.byType(ListView);

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Now playing movies should display message when data is empty',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        nowPlayingState: RequestState.empty,
        popularState: RequestState.loading,
        topRatedState: RequestState.loading,
        message: 'Empty',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final textFinder = find.text('Empty');

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Now playing movies should display message when data is error',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        nowPlayingState: RequestState.error,
        popularState: RequestState.loading,
        topRatedState: RequestState.loading,
        message: 'Failed',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final textFinder = find.text('Failed');

      expect(textFinder, findsOneWidget);
    });
  });

  group('popular movies', () {
    testWidgets(
        'Popular movies should display center progress bar when loading',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        popularState: RequestState.loading,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final centerFinder = find.byType(CircularProgressIndicator);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Popular movies should display data listView when data is loaded',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        popularState: RequestState.success,
        popularList: testMovieList,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final listViewFinder = find.byType(ListView);

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Popular movies should display message when data is empty',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        nowPlayingState: RequestState.success,
        popularState: RequestState.empty,
        topRatedState: RequestState.loading,
        message: 'Empty',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final textFinder = find.text('Empty');

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Popular movies should display message when data is error',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        nowPlayingState: RequestState.success,
        popularState: RequestState.error,
        topRatedState: RequestState.loading,
        message: 'Failed',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final textFinder = find.text('Failed');

      expect(textFinder, findsOneWidget);
    });
  });

  group('top rated movies', () {
    testWidgets(
        'Top rated movies should display center progress bar when loading',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        topRatedState: RequestState.loading,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final centerFinder = find.byType(CircularProgressIndicator);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Top rated movies should display data listView when data is loaded',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        topRatedState: RequestState.success,
        topRatedList: testMovieList,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final listViewFinder = find.byType(ListView);

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Top rated movies should display message when data is empty',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        nowPlayingState: RequestState.success,
        popularState: RequestState.success,
        topRatedState: RequestState.empty,
        message: 'Empty',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final textFinder = find.text('Empty');

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Top rated movies should display message when data is error',
        (widget) async {
      final movieBloc = MovieState.initial().copyWith(
        nowPlayingState: RequestState.success,
        popularState: RequestState.success,
        topRatedState: RequestState.error,
        message: 'Failed',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(movieBloc));
      when(mockBloc.state).thenReturn(movieBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      final textFinder = find.text('Failed');

      expect(textFinder, findsOneWidget);
    });
  });
}
