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

  setUp(() {
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

  testWidgets('Page should display center progress bar when loading',
      (widget) async {
    final tvBloc = TvState.initial().copyWith(
      onAiringState: RequestState.loading,
    );

    when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
    when(mockBloc.state).thenReturn(tvBloc);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await widget.pumpWidget(makeTestableWidget(const OnAiringTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is success',
      (widget) async {
    final tvBloc = TvState.initial().copyWith(
      onAiringState: RequestState.success,
      onAiringList: tSeriesList,
    );

    when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
    when(mockBloc.state).thenReturn(tvBloc);

    final listViewFinder = find.byType(ListView);

    await widget.pumpWidget(makeTestableWidget(const OnAiringTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (widget) async {
    final tvBloc = TvState.initial().copyWith(
      onAiringState: RequestState.empty,
      message: 'Empty data',
    );

    when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
    when(mockBloc.state).thenReturn(tvBloc);

    final textFinder = find.text('Empty data');

    await widget.pumpWidget(makeTestableWidget(const OnAiringTvPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (widget) async {
    final tvBloc = TvState.initial().copyWith(
      onAiringState: RequestState.error,
      message: 'Failed',
    );

    when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
    when(mockBloc.state).thenReturn(tvBloc);

    final textFinder = find.text('Failed');

    await widget.pumpWidget(makeTestableWidget(const OnAiringTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
