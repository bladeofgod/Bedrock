import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider封装类
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;///根据model状态构建页面
  final T model;///你的model
  final Widget child;///此child 为stateless 可以视具体情况使用（一般用不到）
  final Function(T) onModelReady;///model创建好后会调用此方法，根据需要传入

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelReady;

  ProviderWidget2({
    Key key,
    @required this.builder,
    @required this.model1,
    @required this.model2,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;

    if (widget.onModelReady != null) {
      widget.onModelReady(model1, model2);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            create: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            create: (context) => model2,
          )
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}


class ProviderWidget4<A extends ChangeNotifier,B extends ChangeNotifier,
C extends ChangeNotifier,D extends ChangeNotifier> extends StatefulWidget{

  final Widget Function(BuildContext context,A model_1,B model_2,C model_3,D
  model_4,Widget child) builder;

  final A model_1;
  final B model_2;
  final C model_3;
  final D model_4;
  final Widget child;
  final Function(A,B,C,D) onModelReady;


  ProviderWidget4({
    Key key,
    this.builder, this.model_1, this.model_2, this.model_3,
    this.model_4, this.child, this.onModelReady
}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProviderWidgetState4<A,B,C,D>();
  }

}

class ProviderWidgetState4<A extends ChangeNotifier,B extends ChangeNotifier,
C extends ChangeNotifier,D extends ChangeNotifier> extends
State<ProviderWidget4<A,B,C,D>> {

   A model_1;
   B model_2;
   C model_3;
   D model_4;
   @override
  void initState() {
    // TODO: implement initState

     model_1 = widget.model_1;
     model_2 = widget.model_2;
     model_3 = widget.model_3;
     model_4 = widget.model_4;
     if(widget.onModelReady != null){
       widget.onModelReady(model_1,model_2,model_3,model_4);
     }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>(
          create:  (context) => model_1,
        ),
        ChangeNotifierProvider<B>(
          create: (context) => model_2,
        ),
        ChangeNotifierProvider<C>(
          create: (context) => model_3,
        ),
        ChangeNotifierProvider<D>(
          create: (context) => model_4,
        ),
      ],
      child: Consumer4<A,B,C,D>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
















