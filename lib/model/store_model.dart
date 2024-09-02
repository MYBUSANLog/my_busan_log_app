import 'dart:convert';

import 'package:busan_trip/app_http/store_http.dart';
import 'package:busan_trip/vo/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StoreModel extends ChangeNotifier {
  List<Store> stores = [];
  final Map<int, Store> _storeMap = {};
  Map<int, Store> get storeMap => _storeMap;

  Store? getStoreById(int sIdx) {
    return _storeMap[sIdx];
  }

  Future<void> fetchStoreById(int sIdx) async {
    if (!_storeMap.containsKey(sIdx)) {
      Store? store = await StoreHttp.fetchStoreById(sIdx);
      if (store != null) {
        _storeMap[sIdx] = store;
        notifyListeners();
      }
    }
  }
}