import 'dart:convert';

import 'package:busan_trip/app_http/store_http.dart';
import 'package:busan_trip/vo/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StoreModel extends ChangeNotifier {
  List<Store> stores = [];
  final Map<int, Store> _storeMap = {};
  Map<int, Store> get storeMap => _storeMap;

  Store? getStoreById(int s_idx) {
    return _storeMap[s_idx];
  }

  Future<void> fetchStoreById(int s_idx) async {
    if (!_storeMap.containsKey(s_idx)) {
      Store? store = await StoreHttp.fetchStoreById(s_idx);
      if (store != null) {
        _storeMap[s_idx] = store;
        notifyListeners();
      }
    }
  }
}