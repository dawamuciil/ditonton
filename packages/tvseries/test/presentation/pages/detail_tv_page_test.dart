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

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (widget) async {
    final tvBloc = TvState.initial().copyWith(
      detailState: RequestState.success,
      detailTv: tSeriesDetail,
      recommendationState: RequestState.success,
      recommendationList: tSeriesList,
      watchlistStatus: false,
    );

    when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
    when(mockBloc.state).thenReturn(tvBloc);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await widget.pumpWidget(makeTestableWidget(const DetailTvPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (widget) async {
    final tvBloc = TvState.initial().copyWith(
      detailState: RequestState.success,
      detailTv: tSeriesDetail,
      recommendationState: RequestState.success,
      recommendationList: tSeriesList,
      watchlistStatus: true,
    );

    when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
    when(mockBloc.state).thenReturn(tvBloc);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await widget.pumpWidget(makeTestableWidget(const DetailTvPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display SnackBar when added to watchlist',
      (widget) async {
    final tvBloc = TvState.initial().copyWith(
      detailState: RequestState.success,
      detailTv: tSeriesDetail,
      recommendationState: RequestState.success,
      recommendationList: tSeriesList,
      watchlistStatus: false,
      message: watchlistAddSuccess,
    );

    when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
    when(mockBloc.state).thenReturn(tvBloc);

    final watchlistButton = find.byType(ElevatedButton);

    await widget.pumpWidget(makeTestableWidget(const DetailTvPage(id: tId)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await widget.tap(watchlistButton);
    await widget.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(watchlistAddSuccess), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (widget) async {
    final tvBloc = TvState.initial().copyWith(
      detailState: RequestState.success,
      detailTv: tSeriesDetail,
      recommendationState: RequestState.success,
      recommendationList: tSeriesList,
      watchlistStatus: false,
      message: 'Failed',
    );

    when(mockBloc.stream).thenAnswer((_) => Stream.value(tvBloc));
    when(mockBloc.state).thenReturn(tvBloc);

    final watchlistButton = find.byType(ElevatedButton);

    await widget.pumpWidget(makeTestableWidget(const DetailTvPage(id: tId)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await widget.tap(watchlistButton, warnIfMissed: false);
    await widget.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
