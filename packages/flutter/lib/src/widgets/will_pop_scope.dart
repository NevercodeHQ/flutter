// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart = 2.8

import 'framework.dart';
import 'navigator.dart';
import 'routes.dart';

/// Registers a callback to veto attempts by the user to dismiss the enclosing
/// [ModalRoute].
///
/// WillPopScope prevents gestures that makes current pops such as swipe to go back
/// gesture on iOS. To enable this behaviour use custom route which overrides
/// `hasScopedWillPopCallback` getter.
///
/// {@tool dartpad --template=freeform}
///
/// This sample demonstrates how to implement WillPopScope and prevent user from popping
/// current route.
///
/// ```dart
/// /// Flutter code sample for WillPopScope
/// /// This sample demonstrates how to register a callback for when the user wants
/// /// to dismiss the current Route.
///
/// /// `onWillPop` callback can be used to show warning to the user on popping
/// /// the current [Route], preventing user from going to back to unintended Routes.
///
/// import 'package:flutter/material.dart';
///
/// void main() => runApp(MyApp());
///
/// class MyApp extends StatelessWidget {
///   static const String _title = 'WillPopScope Code Sample';
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       title: _title,
///       home: IntialPage(),
///     );
///   }
/// }
///
/// class IntialPage extends StatelessWidget {
///   IntialPage({Key key}) : super(key: key);
///   @override
///   Widget build(BuildContext context) {
///     return new Scaffold(
///       appBar: AppBar(
///         title: const Text('WillPopScope Demo'),
///       ),
///       body: Container(
///         alignment: Alignment.center,
///         child: RaisedButton(
///           onPressed: () {
///             Navigator.push(
///                 context, MaterialPageRoute(builder: (context) => HomePage()));
///           },
///           child: const Text('Go to HomePage', style: TextStyle(fontSize: 20)),
///         ),
///       ),
///     );
///   }
/// }
///
/// class HomePage extends StatelessWidget {
///   HomePage({Key key}) : super(key: key);
///   @override
///   Widget build(BuildContext context) {
///     return WillPopScope(
///       onWillPop: () async {
///         // Add your code here.
///         return Future.value(false);
///       },
///       child: new Scaffold(
///         appBar: AppBar(
///           title: const Text('HomePage'),
///         ),
///         body: Center(
///             child: Text('WillPopScope will now prevent you from going back')),
///       ),
///     );
///   }
/// }
/// ```
///
/// See also:
///
///  * [ModalRoute.addScopedWillPopCallback] and [ModalRoute.removeScopedWillPopCallback],
///    which this widget uses to register and unregister [onWillPop].
class WillPopScope extends StatefulWidget {
  /// Creates a widget that registers a callback to veto attempts by the user to
  /// dismiss the enclosing [ModalRoute].
  ///
  /// The [child] argument must not be null.
  const WillPopScope({
    Key key,
    @required this.child,
    @required this.onWillPop,
  })  : assert(child != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  ///
  /// If the callback returns a Future that resolves to false, the enclosing
  /// route will not be popped.
  final WillPopCallback onWillPop;

  @override
  _WillPopScopeState createState() => _WillPopScopeState();
}

class _WillPopScopeState extends State<WillPopScope> {
  ModalRoute<dynamic> _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.onWillPop != null)
      _route?.removeScopedWillPopCallback(widget.onWillPop);
    _route = ModalRoute.of(context);
    if (widget.onWillPop != null)
      _route?.addScopedWillPopCallback(widget.onWillPop);
  }

  @override
  void didUpdateWidget(WillPopScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(_route == ModalRoute.of(context));
    if (widget.onWillPop != oldWidget.onWillPop && _route != null) {
      if (oldWidget.onWillPop != null)
        _route.removeScopedWillPopCallback(oldWidget.onWillPop);
      if (widget.onWillPop != null)
        _route.addScopedWillPopCallback(widget.onWillPop);
    }
  }

  @override
  void dispose() {
    if (widget.onWillPop != null)
      _route?.removeScopedWillPopCallback(widget.onWillPop);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
