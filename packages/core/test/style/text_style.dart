import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should using textStyle bold when textWidget is used', (widget) async {
    expect(13, kBodyBoldText.fontSize);
    expect(FontWeight.bold, kBodyBoldText.fontWeight);
    expect(0.25, kBodyBoldText.letterSpacing);
  });

  testWidgets('should using textStyle small text when textWidget is used', (widget) async {
    expect(11, kBodySmallText.fontSize);
    expect(FontWeight.w400, kBodySmallText.fontWeight);
    expect(0.25, kBodySmallText.letterSpacing);
  });

  testWidgets('should using textStyle when textTheme is used', (widget) async {
    expect(kTextTheme.headlineSmall, kHeading5);
    expect(kTextTheme.titleLarge, kHeading6);
    expect(kTextTheme.titleMedium, kSubtitle);
    expect(kTextTheme.bodyMedium, kBodyText);
  });
}