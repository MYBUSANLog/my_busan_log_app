import 'package:busan_trip/app_http/res_item_http.dart';
import 'package:flutter/material.dart';

import '../vo/res_item.dart';

class ResItemModel with ChangeNotifier {
  List<ResItem> _restaurants = [];

  List<ResItem> get restaurants => _restaurants;

  // API에서 데이터를 가져와 상태를 업데이트
  Future<void> fetchRestaurants() async {
    _restaurants = await ResItemHttp.fetchAll();
    notifyListeners();
  }
}