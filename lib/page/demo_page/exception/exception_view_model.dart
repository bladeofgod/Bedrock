/*
* Author : LiJiqqi
* Date : 2020/5/29
*/

import 'package:flutter_bedrock/base_framework/view_model/view_state_single_model.dart';
import 'package:flutter_bedrock/service_api/bedrock_repository_proxy.dart';

class ExceptionViewModel extends ViewStateSingleModel{
  @override
  Future loadData() {
    return BedrockRepositoryProxy.getInstance().getSectionOne().getTest();
  }

  @override
  onCompleted(data) {

  }

}









