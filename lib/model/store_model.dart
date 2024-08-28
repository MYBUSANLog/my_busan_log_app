import 'dart:convert';

import 'package:busan_trip/app_http/store_http.dart';
import 'package:busan_trip/vo/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StoreModel extends ChangeNotifier {
  List<Store> stores = [];
  final Map<int, String> _storeMap = {};
  Map<int, String> get storeMap => _storeMap;

  // home_screen 실시간 핫플레이스 5개 정렬(defaultValue = latest)
  Future<void> set5Items() async{
    stores = await StoreHttp.fetch5Stores();
    stores.sort((a, b) => a.ui_rank.compareTo(b.ui_rank));
    notifyListeners();
  }
}