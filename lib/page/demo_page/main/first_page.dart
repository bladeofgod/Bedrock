


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/utils/refresh_helper.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/app_cache_model.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/user_view_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/view_model/first_view_model.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/widget/first_banner.dart';
import 'package:flutter_bedrock/page/demo_page/main_page.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    widget.transportScrollController(scrollController);
    super.initState();
  }


  UserViewModel userViewModel;
  FirstViewModel firstViewModel;

  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
        child: Consumer2<UserViewModel,AppCacheModel>(
      builder: (ctx,userViewModel,cacheModel,child){
        this.userViewModel = userViewModel;
        return ProviderWidget<FirstViewModel>(
          model: FirstViewModel(),
          onModelReady: (model){
            model.initData();
          },
          builder: (ctx,firstModel,child){
            if(firstModel.busy){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            firstViewModel = firstModel;
            ///我顶层定义的有 refresh的属性，可以用这个方法获得，并不一定非要这么写
            return RefreshConfiguration.copyAncestor(context: context,
                child: Container(
                  color: Colors.white,
                  width: getWidthPx(750),
                  height: getHeightPx(1236),
                  ///如果不想要flutter 自带的水印，可以用这个包裹  eg:listview \  scrollview
                  child: getNoInkWellListView(scrollView: SmartRefresher(
                    controller:  firstModel.refreshController,
                    header: HomeRefreshHeader(Colors.black),
                    footer: RefresherFooter(),
                    onRefresh: firstModel.refresh,
                    enablePullDown: firstModel.list.isNotEmpty,
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: <Widget>[
                        ///slivers 内部的子widget 请务必用SliverToBoxAdapter包裹，或者直接使用sliver**widget
                        SliverToBoxAdapter(
                          child: getSizeBox(height: getWidthPx(98),width: getWidthPx(750)),
                        ),
                        ///banner
                        SliverToBoxAdapter(
                          child: buildBanner(),
                        ),

                      ],
                    ),
                  )),
                ));
          },
        );
      },
    ));
  }

  Widget buildBanner(){
    return Container(
      width: getWidthPx(622),
      height: getWidthPx(292),
      child: FirstBanner(
        borderRadius: BorderRadius.circular(getHeightPx(6)),
        index: firstViewModel.ba,
      ),
    );
  }

}




















