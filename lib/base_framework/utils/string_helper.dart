

import 'package:flutter/material.dart';

class StringHelper{
  //to keep setting location same ,and don't cause confuse,
  // there will not use lib : screen_util

  ///划线价格
  static Widget getSlashPrice(String price,double markSp,double sizeSp,{String moneySymbol
      :"\$ "
    ,Color priceColor : Colors.black}){

    return Row(
      children: <Widget>[
        Text(
          "$moneySymbol",
          style: TextStyle(
            color: priceColor,
            fontSize: markSp,
          ),
        ),
        Text(
          "$price",
          style: TextStyle(
              color: priceColor,
              decoration: TextDecoration.lineThrough,
              decorationColor: priceColor,
              fontSize: sizeSp
          ),
        ),
      ],
    );

  }
  ///不带钱符号的驼峰价格
  static Widget getCamelPriceWithoutSymbol(String price,double
  intSp,double decimalSp ,{Color priceColor : Colors.black}){
    return Text.rich(TextSpan(
      children: [
        TextSpan(
          text:"${getDoublePriceInt(double.parse(price))}",
          style: TextStyle(color: priceColor,fontSize: intSp,fontWeight:
          FontWeight.bold),
        ),
        TextSpan(
          text:".",
          style: TextStyle(color: priceColor,fontSize: decimalSp,fontWeight:
          FontWeight.bold),
        ),
        TextSpan(
          text:"${getDoublePriceDecimal(double.parse(price))}",
          style: TextStyle(color: priceColor,fontSize: decimalSp,fontWeight:
          FontWeight.bold),
        ),
      ],
    ));
  }


  ///with symbol no camel
  static Widget getPriceWithoutCamel(String price,double markSp,double priceSp,
      {String moneySymbol :"\$ ",Color priceColor : Colors.black,Color?
      symbolColor,FontWeight fontWeight:FontWeight.normal}){
    return Text.rich(TextSpan(
        children: [
          TextSpan(
            text:"$moneySymbol",
            style: TextStyle(color: symbolColor == null ? priceColor : symbolColor,
                fontSize: markSp,
                fontWeight: fontWeight),
          ),
          TextSpan(
            text:"${double.parse(price).toStringAsFixed(2)}",
            style: TextStyle(color: priceColor,fontSize: priceSp,fontWeight: fontWeight),
          ),
        ]
    ));
  }

  static Widget getPriceWithoutCamelInt(String price,double markSp,double priceSp,
      {String moneySymbol :"\$ ",Color priceColor : Colors.black,Color?
      symbolColor,FontWeight fontWeight:FontWeight.normal}){
    return Text.rich(TextSpan(
        children: [
          TextSpan(
            text:"$moneySymbol",
            style: TextStyle(color: symbolColor == null ? priceColor : symbolColor,
                fontSize: markSp,
                fontWeight: fontWeight),
          ),
          TextSpan(
            text:"$price",
            style: TextStyle(color: priceColor,fontSize: priceSp,fontWeight: fontWeight),
          ),
        ]
    ));
  }

  ///美式价格 没有驼峰
  static Widget getUsaStylePrice({required String originPrice,String priceTail = "",
    String symbol = "\$",Color priceColor = Colors.black,
    Color symbolColor = Colors.black, double? priceSize,double? symbolSize,
    FontWeight priceWeight = FontWeight.w500,FontWeight symbolWeight = FontWeight.w500}){

    String price = formatPriceWithComma(originPrice);

    return Text.rich(TextSpan(
      children: [
        TextSpan(
          text:symbol,
          style: TextStyle(color: symbolColor == null ? priceColor : symbolColor,
              fontSize: symbolSize,
              fontWeight: symbolWeight),
        ),
        TextSpan(
          text:"$price$priceTail",
          style: TextStyle(color: priceColor,fontSize: priceSize,fontWeight: priceWeight),
        ),
      ]
    ));
  }


  ///with symbol
  static Widget getCamelPrice(String price,double markSp,double intSp,double
  decimalSp ,{String moneySymbol :"\$ ",Color priceColor : Colors.black,Color?
  symbolColor,FontWeight fontWeight : FontWeight.bold}){
    return Text.rich(TextSpan(
      children: [
        TextSpan(
          text:"$moneySymbol",
          style: TextStyle(color: symbolColor == null ? priceColor : symbolColor,
              fontSize: markSp,
              fontWeight: fontWeight),
        ),
        TextSpan(
          text:"${getDoublePriceInt(double.parse(price))}",
          style: TextStyle(color: priceColor,fontSize: intSp,fontWeight: fontWeight),
        ),
        TextSpan(
          text:".",
          style: TextStyle(color: priceColor,fontSize: markSp,fontWeight: fontWeight),
        ),
        TextSpan(
          text:"${getDoublePriceDecimal(double.parse(price))}",
          style: TextStyle(color: priceColor,fontSize: decimalSp,fontWeight: fontWeight),
        ),
      ],
    ));
  }


  static String getDoublePriceInt(double price){
    return "${price.truncate()}";
  }

  static String getDoublePriceDecimal(double price){
    return price > 0 ? ((price - price.truncate()).toStringAsFixed(2))
        .substring(2): "00";
  }

  static int paresStringColor(String color){
    if(color == null || color.isEmpty) return 0xFF222222;
    return int.parse(color.replaceFirst("#", "0x"));
  }

  ///获取当前日期不含时间  16/04/2020
  static String getNowDateWithoutTime(){
    DateTime now = DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }

  ///转换时间 按格式: 03/08/2020 10:58:32
  static String transformDateTimeWithSlash(String timeStamp){
    DateTime now = DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);
    return "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}:${now.second}";
  }


  ///格式化价格 每三位以逗号区分（右到左）
  static String formatPriceWithComma(String price){
    if(price.length <= 3) return price;
    String reverseP = price.split("").reversed.join("");
    var arr = [];
    for(int i=0; i < reverseP.length;i++){
      if(i % 3 == 0){
        arr.add(reverseP.substring(0,i).split("").reversed.join(""));
        if((reverseP.length - i) < 3 ){
          arr.add(reverseP.substring(i,reverseP.length).split("").reversed.join(""));
        }
      }

    }
    debugPrint("format price : ${arr.reversed.join(",")}");
    String temp = arr.reversed.join(",");
    return temp.substring(0,temp.length-1);
  }


  ///check string is null || empty
  static bool checkStringIsNullOrEmpty(String str){
    return (str == null || str.isEmpty);
  }

}















