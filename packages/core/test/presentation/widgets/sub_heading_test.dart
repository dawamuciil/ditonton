import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('container should display when isPressed is false',
      (widget) async {
    await widget.pumpWidget(makeTestableWidget(const SubHeading(
      title: 'title',
      isPressed: false,
    )));

    final containerFinder = find.byType(Container);

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('ink well should display when isPressed is true',
      (widget) async {
    await widget.pumpWidget(makeTestableWidget(const SubHeading(
      title: 'title',
      isPressed: true,
    )));

    final gestureFinder = find.byType(GestureDetector);
    final textFinder = find.text('See More');

    expect(gestureFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });
}
