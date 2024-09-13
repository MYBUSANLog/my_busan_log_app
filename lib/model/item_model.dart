import 'package:busan_trip/app_http/item_http.dart';
import 'package:flutter/material.dart';
import '../vo/item.dart';

class ItemModel extends ChangeNotifier {
  List<Item> items = [];
  List<Item> hotItem6 = [];
  List<Item> newItem6 = [];


  Future<void> setAllItems({required String sortBy}) async{
    try {
      List<Item> newitems = await ItemHttp.fetchAllSortBy(sortBy);
      items.addAll(newitems);
      notifyListeners();
    } catch (e) {
      // 오류 처리
    }
  }

  Future<void> setItems() async{
    items = await ItemHttp.fetchAll();
    notifyListeners();
  }

  // home_screen 인기상품 모음.zip 5개 정렬
  Future<void> set6HotItems() async{
    hotItem6 = [];
    hotItem6 = await ItemHttp.fetch6HotItems();
    hotItem6.sort((a, b) => a.ui_rank.compareTo(b.ui_rank));
    notifyListeners();
  }

  Future<void> set6NewItems() async{
    newItem6 = [];
    newItem6 = await ItemHttp.fetch6NewItems();
    newItem6.sort((a, b) => a.ui_rank.compareTo(b.ui_rank));
    notifyListeners();
  }

  void clearItems() {
    items.clear(); // 리스트 비우기
    notifyListeners(); // 상태 변경 알림
  }
}