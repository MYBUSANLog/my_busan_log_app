import 'package:busan_trip/app_http/item_http.dart';
import 'package:flutter/material.dart';
import '../vo/item.dart';

class ItemModel extends ChangeNotifier {
  List<Item> items = [];


  Future<void> setItems() async{
    items = await ItemHttp.fetchAll();
    notifyListeners();
  }
}