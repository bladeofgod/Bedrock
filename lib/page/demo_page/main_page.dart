



import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/first_page.dart';


//typedef TransportScrollController = Function(ScrollController controller);

class MainPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }

}

class MainPageState extends BaseState<MainPage> {

  final PageController pageController = PageController();

  ScrollController firstController;

  List<Widget> pageList = [
    FirstPage()
  ];

  @override
  Widget build(BuildContext context) {

    throw UnimplementedError();
  }
}















