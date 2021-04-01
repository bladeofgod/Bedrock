import 'dart:async';

import 'package:flutter/services.dart';

/// Wraps MMKV on iOS) and  Android, providing
/// a persistent store for simple data.
class MmkvFlutter {
  static const MethodChannel _channel = const MethodChannel('mmkv_flutter');

  static const String KEY = 'key';
  static const String VALUE = 'value';

  static const String _prefix = 'mmkv.flutter.';
  static MmkvFlutter _instance;
  final Map<String, Object> _mmkvCache;

  MmkvFlutter._(this._mmkvCache);

  static Future<MmkvFlutter> getInstance() async {
    if (_instance == null) {
      final Map<String, Object> mmkvMap = <String, Object>{};
      _instance = MmkvFlutter._(mmkvMap);
    }
    return _instance;
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a bool.
  Future<bool> getBool(String key) async{
    if (_mmkvCache.containsKey(key)) {
      return _mmkvCache[key];
    } else {
      final Map<String, dynamic> params = <String, dynamic>{KEY: '$_prefix$key'};
      return await _channel.invokeMethod('getBool', params).then<bool>((result){
        _mmkvCache[key] = result;
        return result;
      });
    }
  }

  /// Reads a value from persistent storage, throwing an exception if it's not an int.
  Future<int> getInt(String key) async{
    if (_mmkvCache.containsKey(key)) {
      print('get value from catch');
      return _mmkvCache[key];
    } else {
      print('get value from channel');
      final Map<String, dynamic> params = <String, dynamic>{KEY: '$_prefix$key'};
      return await _channel.invokeMethod('getInt', params).then<int>((result){
        _mmkvCache[key] = result;
        return result;
      });
    }
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a long.
  Future<int> getLong(String key)async{
    if (_mmkvCache.containsKey(key)) {
      return _mmkvCache[key];
    } else {
      final Map<String, dynamic> params = <String, dynamic>{KEY: '$_prefix$key'};
      return await _channel.invokeMethod('getLong', params).then<int>((result){
        _mmkvCache[key] = result;
        return result;
      });
    }
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a double.
  Future<double> getDouble(String key)async{
    if (_mmkvCache.containsKey(key)) {
      return _mmkvCache[key];
    } else {
      final Map<String, dynamic> params = <String, dynamic>{KEY: '$_prefix$key'};
      return await _channel.invokeMethod('getDouble', params).then<double>((result){
        _mmkvCache[key] = result;
        return result;
      });
    }
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a string.
  Future<String> getString(String key)async{
    if (_mmkvCache.containsKey(key)) {
      return _mmkvCache[key];
    } else {
      final Map<String, dynamic> params = <String, dynamic>{KEY: '$_prefix$key'};
      return await _channel.invokeMethod('getString', params).then<String>((result){
        _mmkvCache[key] = result;
        return result;
      });
    }
  }



  /// Saves a boolean [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [removeByKey()] on the [key].
  Future<bool> setBool(String key, bool value) => _setValue('Bool', key, value);

  /// Saves an integer  [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [removeByKey()] on the [key].
  Future<bool> setInt(String key, int value) => _setValue('Int', key, value);

  /// Saves a long integer  [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [removeByKey()] on the [key].
  Future<bool> setLong(String key, int value) => _setValue('Long', key, value);

  /// Saves a double  [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [removeByKey()] on the [key].
  Future<bool> setDouble(String key, double value) => _setValue('Double', key, value);

  /// Saves a string  [value] to persistent storage in the background.
  ///
  /// If [value] is null, this is equivalent to calling [removeByKey()] on the [key].
  Future<bool> setString(String key, String value) => _setValue('String', key, value);

  /// Removes an entry from persistent storage.
  Future<bool> removeByKey(String key) => _setValue(null, key, null);

  Future<bool> _setValue(String valueType, String key, Object value) async {
    final Map<String, dynamic> params = <String, dynamic>{KEY: '$_prefix$key'};

    if (value == null) {
      _mmkvCache.remove(key);
      return await _channel.invokeMethod('removeByKey', params).then<bool>((dynamic result) => result);
    } else {
      _mmkvCache[key] = value;
      params[VALUE] = value;
      return await _channel.invokeMethod('set$valueType', params).then<bool>((dynamic result) => result);
    }
  }

  /// Completes with true once the user preferences for the app has been cleared.
  Future<bool> clear() async {
    _mmkvCache.clear();
    return await _channel.invokeMethod('clear');
  }
}
