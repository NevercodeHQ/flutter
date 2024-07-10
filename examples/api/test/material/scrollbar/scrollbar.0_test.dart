// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_api_samples/material/scrollbar/scrollbar.1.dart' as example;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Scrollbar appears on drag and', (WidgetTester tester) async {
    await tester.pumpWidget(
      const example.ScrollbarExampleApp(),
    );


    final Finder scrollbarFinder = find.byType(Scrollbar).last;

    expect(scrollbarFinder, isNot(paints..rect()));
    await tester.fling(scrollbarFinder.last, const Offset(0, -300), 10.0);
    expect(scrollbarFinder.last, paints..rect());
  });

  testWidgets('Scrollbar scrolls the content', (WidgetTester tester) async {
    await tester.pumpWidget(
      const example.ScrollbarExampleApp(),
    );

    expect(find.text('item 0'), findsOne);
    expect(find.text('item 9'), findsNothing);

    await tester.fling(find.byType(Scrollbar).last, const Offset(0, -300), 10.0);
   // await tester.pumpAndSettle();

    expect(find.text('item 0'), findsNothing);
    expect(find.text('item 9'), findsOne);
  });
}
