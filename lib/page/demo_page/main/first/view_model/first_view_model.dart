/*
* Author : LiJiqqi
* Date : 2020/6/1
*/



import 'package:flutter_bedrock/base_framework/view_model/view_state_refresh_list_model.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state_single_model.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/entity/first_card_entity.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/entity/first_entity.dart';
import 'package:flutter_bedrock/service_api/bedrock_repository_proxy.dart';


class FirstViewModel extends ViewStateSingleModel{
  int pageNum = 1;
  int pageSize = 8;

  FirstEntity firstEntity;
  List<FirstCardEntity> cardList = [];


  @override
  Future loadData() {
    List<Future> futures = [];
    futures.add(BedrockRepositoryProxy.getInstance().getSectionOne().getFirstEntity());
    futures.add(BedrockRepositoryProxy.getInstance().getSectionOne().getFirstListCard(pageNum, pageSize));
    var result = Future.wait(futures);
    return result;
  }

  @override
  onCompleted(data) {
    firstEntity = data[0];
    cardList.addAll(data[1]);

  }






}




















