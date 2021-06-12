


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';

class SimpleListPage extends PageState{
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: 750.w,height: 1334.h,
      child: ListView(
        children: List.generate(40, (index) => generateWidget(()=>_ListItem(index))).toList(),
        //children: List.generate(40, (index) => _NormalItem(index: index,)).toList(),
      ),
    ));
  }

}

class _NormalItem extends StatefulWidget{
  final int index;

  const _NormalItem({Key? key, this.index = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NormalItemState();
  }
}

class _NormalItemState extends State<_NormalItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.w,color: widget.index % 2 == 0 ? Colors.blue : Colors.red,
    );
  }
}


class _ListItem extends WidgetState{

  int index;

  _ListItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.w,color: index % 2 == 0 ? Colors.blue : Colors.red,
    );
  }

}






















