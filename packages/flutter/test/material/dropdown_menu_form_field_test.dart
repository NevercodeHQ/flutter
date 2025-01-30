// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown_menu_form_field.dart';
import 'package:flutter_test/flutter_test.dart';

enum MenuItem {
  menuItem0('Item 0'),
  menuItem1('Item 1'),
  menuItem2('Item 2'),
  menuItem3('Item 3');

  const MenuItem(this.label);
  final String label;
}

void main() {
  final List<DropdownMenuEntry<MenuItem>> menuEntries = <DropdownMenuEntry<MenuItem>>[];

  for (final MenuItem value in MenuItem.values) {
    final DropdownMenuEntry<MenuItem> entry = DropdownMenuEntry<MenuItem>(
      value: value,
      label: value.label,
    );
    menuEntries.add(entry);
  }

  Finder findMenuItem(MenuItem menuItem) {
    // For each menu items there are two MenuItemButton widgets.
    // The last one is the real button item in the menu.
    // The first one is not visible, it is part of _DropdownMenuBody
    // which is used to compute the dropdown width.
    return find.widgetWithText(MenuItemButton, menuItem.label).last;
  }

  testWidgets('Creates an underlying DropdownMenu', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DropdownMenuFormField<MenuItem>(dropdownMenuEntries: menuEntries)),
      ),
    );

    expect(find.byType(DropdownMenu<MenuItem>), findsOne);
  });

  testWidgets('Dropdown menu can be opened and contains all the items', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DropdownMenuFormField<MenuItem>(dropdownMenuEntries: menuEntries)),
      ),
    );

    await tester.tap(find.byType(DropdownMenu<MenuItem>));
    await tester.pump();

    for (final MenuItem item in MenuItem.values) {
      expect(findMenuItem(item), findsOne);
    }
  });

  testWidgets('Passes enabled to underlying DropddownMenu', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DropdownMenuFormField<MenuItem>(dropdownMenuEntries: menuEntries)),
      ),
    );

    // DropdownMenuFormField.enabled defaults to true.
    DropdownMenu<MenuItem> dropdownMenu = tester.widget(find.byType(DropdownMenu<MenuItem>));
    expect(dropdownMenu.enabled, true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DropdownMenuFormField<MenuItem>(enabled: false, dropdownMenuEntries: menuEntries),
        ),
      ),
    );

    dropdownMenu = tester.widget(find.byType(DropdownMenu<MenuItem>));
    expect(dropdownMenu.enabled, false);
  });

  testWidgets('Passes width to underlying DropddownMenu', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DropdownMenuFormField<MenuItem>(dropdownMenuEntries: menuEntries)),
      ),
    );

    // DropdownMenuFormField.width defaults to null.
    DropdownMenu<MenuItem> dropdownMenu = tester.widget(find.byType(DropdownMenu<MenuItem>));
    expect(dropdownMenu.width, null);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DropdownMenuFormField<MenuItem>(width: 100, dropdownMenuEntries: menuEntries),
        ),
      ),
    );

    dropdownMenu = tester.widget(find.byType(DropdownMenu<MenuItem>));
    expect(dropdownMenu.width, 100);
  });

  testWidgets('Passes menuHeight to underlying DropddownMenu', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DropdownMenuFormField<MenuItem>(dropdownMenuEntries: menuEntries)),
      ),
    );

    // DropdownMenuFormField.menuHeight defaults to null.
    DropdownMenu<MenuItem> dropdownMenu = tester.widget(find.byType(DropdownMenu<MenuItem>));
    expect(dropdownMenu.menuHeight, null);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DropdownMenuFormField<MenuItem>(menuHeight: 100, dropdownMenuEntries: menuEntries),
        ),
      ),
    );

    dropdownMenu = tester.widget(find.byType(DropdownMenu<MenuItem>));
    expect(dropdownMenu.menuHeight, 100);
  });

  testWidgets('Passes menuHeight to underlying DropddownMenu', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DropdownMenuFormField<MenuItem>(dropdownMenuEntries: menuEntries)),
      ),
    );

    // DropdownMenuFormField.menuHeight defaults to null.
    DropdownMenu<MenuItem> dropdownMenu = tester.widget(find.byType(DropdownMenu<MenuItem>));
    expect(dropdownMenu.menuHeight, null);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DropdownMenuFormField<MenuItem>(menuHeight: 100, dropdownMenuEntries: menuEntries),
        ),
      ),
    );

    dropdownMenu = tester.widget(find.byType(DropdownMenu<MenuItem>));
    expect(dropdownMenu.menuHeight, 100);
  });
}
