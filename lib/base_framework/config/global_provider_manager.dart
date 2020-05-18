

/*
* 全局性provider
* 可以在此配置 全局性model
* eg: user.model et.
*
* */


import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers =[
  ...independentServices,
  ...dependentServices,
];

/// 应用级 独立 model
List<SingleChildWidget> independentServices = [
  //ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
  ChangeNotifierProvider<LocaleModel>.value(value: LocaleModel()),
  //设备model
  ChangeNotifierProvider<DeviceModel>.value(value: DeviceModel()),
  //global app cache model
  ChangeNotifierProvider<AppCacheModel>.value(value: AppCacheModel()),
//  ///这里应该放入一个购物车
//  ChangeNotifierProvider<GlobalCartGoodsModel>.value(value:
//  GlobalCartGoodsModel()),
  ///2020.3.10  目前应该没有购物车等可以与用户绑定,这里将用户model抽到上层
  ChangeNotifierProvider<UserViewModel>.value(value: UserViewModel()),

];


/// 需要依赖的model
/// eg :UserModel组合 购物车model （后续可能添加别的）
List<SingleChildWidget> dependentServices = [

//  ChangeNotifierProxyProvider<GlobalCartGoodsModel, UserModel>(
//    update: (context, globalCartGoodsModel, userModel) =>
//    userModel ?? UserModel(globalCartGoodsModel: globalCartGoodsModel),
//  ),
//
//  ChangeNotifierProxyProvider<UserModel,StoreModel>(
//    update: (context,userModel,storeModel)
//    => storeModel ?? StoreModel(userModel: userModel,cartGoodsModel: userModel.globalCartGoodsModel),
//  ),
];

