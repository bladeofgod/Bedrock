


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/view_model/single_view_state_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:provider/provider.dart';

class _DemoViewModel extends SingleViewStateModel {

  int selectorValue = 1;

  void updateSelectorValue() {
    selectorValue++;
    notifyListeners(refreshSelector: true);
  }

  int pageValue = 1;

  void updatePageValue() {
    pageValue++;
    notifyListeners();
  }

  @override
  Future? loadData() {

  }

  @override
  onCompleted(data) {

  }

}

class SelectorDemo extends PageState{
  late _DemoViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = _DemoViewModel();
  }

  ///注意查看两个按钮所触发的 debugPrint的输出

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: ProviderWidget<_DemoViewModel>(
        builder: (ctx,model,child) {
          debugPrint('build page');
          return _buildPage();
        },
        model: vm));
  }

  Widget _buildPage() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${vm.pageValue}',),
          getSizeBox(height: 40),
          RaisedButton(onPressed: () {
            vm.updatePageValue();
          },child: Text('refresh page'),),

          Selector<_DemoViewModel,int>(
            selector: (ctx,model) {
              return model.selectorValue;
            },
            builder: (ctxx,value,child) {
              debugPrint('build selector');
              return Text('$value',);
            },
          ),
          getSizeBox(height: 40),
          RaisedButton(onPressed: () {
            vm.updateSelectorValue();
          },child: Text('refresh selector'),),
        ],
      ),
    );
  }

}


















