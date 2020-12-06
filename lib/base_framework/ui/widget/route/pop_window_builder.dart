


import 'package:flutter/cupertino.dart';
import 'package:flutter/semantics.dart';

typedef PopWidgetBuilder = Widget Function(BuildContext context);
///路由将无法观测到
class PopWindowBuilder<T> extends OverlayRoute<T>{

  final PopWidgetBuilder builder;
  final bool maintainState;

  PopWindowBuilder(this.builder,{this.maintainState = true});


  // We cache the part of the modal scope that doesn't change from frame to
  // frame so that we minimize the amount of building that happens.
  Widget _modalScopeCache;



  // one of the builders
  Widget _buildModalScope(BuildContext context) {
    // To be sorted before the _modalBarrier.
    return _modalScopeCache ??= Semantics(
        sortKey: const OrdinalSortKey(0.0),
        child: Builder(builder: (ctx){
          return builder(ctx);
        })
    );
  }

  OverlayEntry _modalScope;

  @override
  Iterable<OverlayEntry> createOverlayEntries()sync* {
    yield _modalScope = OverlayEntry(builder: _buildModalScope, maintainState: maintainState);
  }
}