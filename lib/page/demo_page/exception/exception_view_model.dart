/*
* Author : LiJiqqi
* Date : 2020/5/29
*/

import 'package:flutter_bedrock/base_framework/view_model/single_view_state_model.dart';
import 'package:flutter_bedrock/service_api/bedrock_repository_proxy.dart';

class ExceptionViewModel extends SingleViewStateModel{

  final String explain = """
  Debug模式下，虽然我们抛出的异常成功捕捉，但是依然可以看到log里还有未捕捉到的异常，如:\n
  throw assureDioError(_e ?? err, requestOptions);
  这个过程中，程序是正常运行的。\n据dio issue上来看，这个应该是flutter的bug，因为在release模式下是可以正常捕捉的。\n
  见：https://github.com/flutterchina/dio/issues/655
  """;


  @override
  Future loadData() {
    return BedrockRepositoryProxy.getInstance().getSectionOne().getTest();
  }

  @override
  onCompleted(data) {

  }

}









