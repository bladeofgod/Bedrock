


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/app_cache_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/page/demo_page/main_page.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget{

  final TransportScrollController transportScrollController;


  FirstPage(this.transportScrollController);

  @override
  State<StatefulWidget> createState() {
    return FirstPageState();
  }

}

class FirstPageState extends BaseState<FirstPage> {

  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(child: Consumer<AppCacheModel>(
      builder: (ctx,cacheModel,child){
        return ProviderWidget();
      },
    ));
  }
}




















