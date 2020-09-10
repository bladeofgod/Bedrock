



import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/detail_image_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/utils/refresh_helper.dart';
import 'package:flutter_bedrock/base_framework/utils/show_image_util.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/app_cache_model.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/user_view_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/second/entity/second_entity.dart';
import 'package:flutter_bedrock/page/demo_page/main/second/view_model/second_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';





class SecondPageState extends PageState with AutomaticKeepAliveClientMixin {


  SecondViewModel secondViewModel;
  UserViewModel userViewModel;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
        child: Consumer2<UserViewModel,AppCacheModel>(
      builder: (ctx,userViewModel,cacheModel,child){
        this.userViewModel = userViewModel;
        return ProviderWidget<SecondViewModel>(
          model: SecondViewModel(),
          onModelReady: (model){
            model.initData();
          },
          builder: (ctx,model,child){

            if(model.busy){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            secondViewModel = model;
            return RefreshConfiguration.copyAncestor(context: context,
                child: getNoInkWellListView(
                    scrollView: SmartRefresher(
                      controller:  secondViewModel.refreshController,
                      header: HomeRefreshHeader(Colors.black),
                      footer: RefresherFooter(),
                      onRefresh: secondViewModel.refresh,
                      onLoading: secondViewModel.loadMore,
//                    enablePullDown: true,
                    enablePullUp: true,
                      child: ListView.builder(
                        itemCount: model.list.length,
                          itemBuilder: (ctx,index){
                            return buildItem(secondViewModel.list[index],index);
                          }),
                    )));
          },
        );
      },
    ));
  }
  Widget buildItem(SecondEntity entity,int index){
    return GestureDetector(
      onTap: (){
        push(DetailImageWidgetState([entity.img]));
      },
      child: Container(
        color: index%2 == 0 ?  Colors.greenAccent[400]:Colors.lightBlueAccent[400],
        margin: EdgeInsets.only(top: getWidthPx(28), left: getWidthPx(40), right: getWidthPx(40)),
        padding: EdgeInsets.all(10),
        width: getWidthPx(670),
        height: getWidthPx(420),
        child: Column(
          children: <Widget>[
            ShowImageUtil.showImageWithDefaultError(entity.img, getWidthPx(650), getWidthPx(300),
                borderRadius: getHeightPx(16)),
            getSizeBox(height: getWidthPx(30)),
            Text("${entity.title} -- ${userViewModel.hasUser?userViewModel.getUserName:"用户未登录"}",
              style: TextStyle(color: Colors.black,fontSize: getSp(32)),),
          ],
        ),
      ),
    );

  }



  @override
  bool get wantKeepAlive => true;

}













