import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvBloc mockBloc;

  setUpAll(() {
    mockBloc = MockTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('on airing tv', () {
    testWidgets(
        'Now playing movies should display center progress bar when loading',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        onAiringState: RequestState.loading,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final centerFinder = find.byType(CircularProgressIndicator);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Now playing movies should display data listView when data is loaded',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        onAiringState: RequestState.success,
        onAiringList: tSeriesList,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final listViewFinder = find.byType(ListView);

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Now playing movies should display message when data is empty',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        onAiringState: RequestState.empty,
        popularState: RequestState.loading,
        topRatedState: RequestState.loading,
        message: 'Empty',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final textFinder = find.text('Empty');

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Now playing movies should display message when data is error',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        onAiringState: RequestState.error,
        popularState: RequestState.loading,
        topRatedState: RequestState.loading,
        message: 'Failed',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final textFinder = find.text('Failed');

      expect(textFinder, findsOneWidget);
    });
  });

  group('popular movies', () {
    testWidgets(
        'Popular movies should display center progress bar when loading',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        popularState: RequestState.loading,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final centerFinder = find.byType(CircularProgressIndicator);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Popular movies should display data listView when data is loaded',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        popularState: RequestState.success,
        popularList: tSeriesList,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final listViewFinder = find.byType(ListView);

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Popular movies should display message when data is empty',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        onAiringState: RequestState.success,
        popularState: RequestState.empty,
        topRatedState: RequestState.loading,
        message: 'Empty',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final textFinder = find.text('Empty');

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Popular movies should display message when data is error',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        onAiringState: RequestState.success,
        popularState: RequestState.error,
        topRatedState: RequestState.loading,
        message: 'Failed',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final textFinder = find.text('Failed');

      expect(textFinder, findsOneWidget);
    });
  });

  group('top rated movies', () {
    testWidgets(
        'Top rated movies should display center progress bar when loading',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        topRatedState: RequestState.loading,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final centerFinder = find.byType(CircularProgressIndicator);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Top rated movies should display data listView when data is loaded',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        topRatedState: RequestState.success,
        topRatedList: tSeriesList,
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final listViewFinder = find.byType(ListView);

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Top rated movies should display message when data is empty',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        onAiringState: RequestState.success,
        popularState: RequestState.success,
        topRatedState: RequestState.empty,
        message: 'Empty',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final textFinder = find.text('Empty');

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Top rated movies should display message when data is error',
        (widget) async {
      final tvBloc = TvState.initial().copyWith(
        onAiringState: RequestState.success,
        popularState: RequestState.success,
        topRatedState: RequestState.error,
        message: 'Failed',
      );

      when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
      when(mockBloc.state).thenReturn(tvBloc);

      await widget.pumpWidget(makeTestableWidget(const HomeTvPage()));

      final textFinder = find.text('Failed');

      expect(textFinder, findsOneWidget);
    });
  });
}
