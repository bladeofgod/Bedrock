import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';
import 'package:flutter_bedrock/generated/l10n.dart';




class LocaleModel extends ChangeNotifier {
//  static const localeNameList = ['auto', '中文', 'English'];
///Platform.localeName
///有些手机 简体中文是 zh_Hans_CN 繁体是 zh_Hant_TW
  ///有些手机 中文简体是 zh_CN 繁体是 zh_TW
  ///台湾标识建议使用tw-CH，zh_TW可能引起问题
  //static const localeValueList = ['', 'zh-CH', 'en-US',"tw-CH"];
  static const localeValueList = ['', 'zh-CH', 'en-US'];

  //
  static const kLocaleIndex = 'kLocaleIndex';

  int _localeIndex = 1;

  int get localeIndex => _localeIndex;

  Locale get locale {
    //初始化放在全局， 放在下面会导致每次刷新index 并且导致国际化切换失败
    //_localeIndex = 1;
    if (_localeIndex > 0) {
      var value = localeValueList[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return  null;
  }

  LocaleModel() {
    _localeIndex = SpUtil.getInt(kLocaleIndex) == 0 ? 2 : SpUtil.getInt(kLocaleIndex);
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    SpUtil.putInt(kLocaleIndex, index);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return '简体中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
}
