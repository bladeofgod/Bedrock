



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/first_page.dart';
import 'package:flutter_bedrock/page/demo_page/main/second_page.dart';
import 'package:flutter_bedrock/page/demo_page/main/third_page.dart';
import 'package:oktoast/oktoast.dart';


typedef TransportScrollController = Function(ScrollController controller);



class MainPageState extends PageState {

  final PageController pageController = PageController();
  int selectIndex = 0;

  ScrollController firstController;


  DateTime lastPress;

  jumpByIndex(int index){
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
        isSetDark: true,
        child: Container(
          color: Colors.white,
          width: getWidthPx(750),height: getHeightPx(1334),
          child: Scaffold(
            body: WillPopScope(
              onWillPop: ()async{
                ///拦截后退键
                ///1秒连点2次退出
                if(lastPress == null ||
                      DateTime.now().difference(lastPress) >  Duration(seconds: 1)){
                  lastPress = DateTime.now();
                  showToast("再点一次退出");
                  return false;
                }
                return true;
              },
              child:Column(
                children: <Widget>[
                  ///page
                  Expanded(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: <Widget>[
                        FirstPageState((controller){
                          firstController = controller;
                        }).generateWidget(),
                        SecondPageState().generateWidget(),
                        ThirdPagePageState().generateWidget(),
                      ],
                      onPageChanged: (index){
                        setState(() {
                          selectIndex = index;
                        });
                      },
                    ),
                  ),
                  Divider(
                    height: getHeightPx(2),
                    color: Color.fromRGBO(206, 206, 206, 1),
                  ),
                  ///bottom
                  Container(
                    color: Colors.white,
                    height: getWidthPx(96),
                    padding: EdgeInsets.symmetric(horizontal: getWidthPx(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        buildBottomItem(index: 0,
                            icon: normalIcon(Icons.vignette),iconActive: activeIcon(Icons.vignette)),
                        buildBottomItem(index: 1,
                            icon: normalIcon(Icons.ac_unit),iconActive: activeIcon(Icons.ac_unit)),
                        buildBottomItem(index: 2,
                            icon: normalIcon(Icons.account_circle),iconActive: activeIcon(Icons.account_circle)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget normalIcon(IconData iconData){
    return Icon(iconData,color: Colors.grey,);
  }

  Widget activeIcon(IconData iconData){
    return Icon(iconData,color: Colors.blue,);
  }

  Widget buildBottomItem({int index,Icon icon,Icon iconActive,}){
    return GestureDetector(
      onTap: (){
        if(selectIndex != index){
          pageController.jumpToPage(index);
        }else if(selectIndex == 0){
          firstController?.animateTo(0, duration: Duration(microseconds: 500), curve: Curves.easeIn);
        }
      },
      child: Container(
        width: getWidthPx(80),height: getWidthPx(80),
        child: selectIndex == index ? iconActive : icon,
      ),
    );
  }

}















