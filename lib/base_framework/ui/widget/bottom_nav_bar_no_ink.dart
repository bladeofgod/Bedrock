

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class BottomNavBarNoInk extends StatefulWidget{

  IndexModel indexModel;

  final width;
  final height;
  List<BottomNavigationBarItem> items;

  int currentIndex;
  ValueChanged<int> onTap;

  BottomNavBarNoInk({@required this.width
    ,@required this.
    height,@required this.items,
    this.currentIndex,this.onTap}) : indexModel = IndexModel(currentIndex);


  @override
  State<StatefulWidget> createState() {

    return BottomNavBarNoInkState();
  }
}

class BottomNavBarNoInkState extends State<BottomNavBarNoInk> {

  List<Widget> barItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    transfer2Widget();
  }

  transfer2Widget(){
    for(int i=0; i< widget.items.length;i++){
      barItems.add(GestureDetector(
        onTap: (){
          widget.onTap(i);
          model?.setIndex(i);
//          Provider.of<IndexModel>(context)
//            ..setIndex(i);
        },
        child: BottomNoInkBarItem(item: widget.items[i],index: i,),
      ));
    }
  }
  IndexModel model ;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (ctx){
        model = IndexModel(widget.currentIndex);
        return model;
      },
      child:Container(
        width: widget.width,
        height: widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: barItems,
        ),
      ) ,
    ) ;
  }


//  List<Widget> generateNoInkWidgets(){
//    return widget.items.map((widget){
//      return Theme(
//        data: ThemeData(splashFactory: NoInkWellFactory()),
//        child: widget,
//      );
//    }).toList();
//  }

}


class BottomNoInkBarItem extends StatefulWidget{

  int index;
  BottomNavigationBarItem item;


  BottomNoInkBarItem({this.item,this.index});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomNoInkBarItemState();
  }

}

class BottomNoInkBarItemState extends State<BottomNoInkBarItem> {
  @override
  Widget build(BuildContext context) {

    return Consumer<IndexModel>(
      builder: (ctx,model,child){
        //print("model inde ${model.index}----- widget index ${widget.index}");
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  //未激活状态
                  Offstage(
                    offstage: model.index == widget.index,
                    child: widget.item.icon,
                  ),
                  Offstage(
                    offstage: model.index != widget.index,
                    child: widget.item.activeIcon,
                  ),
                ],
              ),
              ///title
              if(widget.item.title != null)
              widget.item.title
            ],
          ),
        );
      },
    );
  }
}


class IndexModel extends ChangeNotifier{
  int selectIndex;

  IndexModel(@required this.selectIndex);

  get index => selectIndex;

  setIndex(int index){
    selectIndex = index;
    notifyListeners();
  }

}










