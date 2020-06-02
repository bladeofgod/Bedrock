/*
* Author : LiJiqqi
* Date : 2020/6/1
*/



import 'package:flutter_bedrock/base_framework/view_model/view_state_refresh_list_model.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state_single_model.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/entity/first_card_entity.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/entity/first_entity.dart';
import 'package:flutter_bedrock/service_api/bedrock_repository_proxy.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class FirstViewModel extends ViewStateSingleModel{
  int pageNum = 1;
  int pageSize = 8;

  RefreshController refreshController;


  FirstViewModel(){
    refreshController = RefreshController();
  }

  FirstEntity firstEntity;
  List<FirstCardEntity> cardList = [];


  @override
  Future loadData() {
    cardList.clear();
    List<Future> futures = [];
    futures.add(BedrockRepositoryProxy.getInstance().getSectionOne().getFirstEntity());
    futures.add(BedrockRepositoryProxy.getInstance().getSectionOne().getFirstListCard(pageNum, pageSize));
    var result = Future.wait(futures);
    return result;
  }

  loadMore()async{
    pageNum +=1;
    BedrockRepositoryProxy.getInstance().getSectionOne()
        .getFirstListCard(pageNum, pageSize).then((list){
          if(list.isEmpty){
            refreshController.loadNoData();
          }else{
            cardList.addAll(list);
            refreshController.loadComplete();
            notifyListeners();
          }
    });
  }

  @override
  onCompleted(data) {
    firstEntity = data[0];
    cardList.addAll(data[1]);

  }






}




















