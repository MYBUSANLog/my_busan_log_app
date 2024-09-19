import 'package:busan_trip/app_http/res_item_http.dart';
import 'package:flutter/material.dart';

import '../vo/res_item.dart';

class ResItemModel with ChangeNotifier {
  List<ResItem> _restaurants = [];

  List<ResItem> get restaurants => _restaurants;

  Future<void> setAllRestaurants({required int start, required int count}) async{
    try {
      List<ResItem> newRestaurants = await ResItemHttp.fetchAllRestaurants(start, count);
      restaurants.addAll(newRestaurants);
      notifyListeners();
    } catch (e) {
      // 오류 처리
    }
  }

  // API에서 데이터를 가져와 상태를 업데이트
  Future<void> fetchRestaurants() async {
    _restaurants = await ResItemHttp.fetchAll();
    notifyListeners();
  }
}