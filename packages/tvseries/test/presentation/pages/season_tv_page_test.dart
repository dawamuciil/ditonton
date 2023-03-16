import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Season movies should display data listView when data is loaded',
      (widget) async {
    await widget.pumpWidget(makeTestableWidget(
      const SeasonTvPage('title', [tSeason]),
    ));

    final listViewFinder = find.byType(ListView);

    expect(listViewFinder, findsOneWidget);
  });
}
