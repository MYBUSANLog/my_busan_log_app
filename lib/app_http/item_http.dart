import 'dart:convert';

import '../vo/item.dart';
import 'package:http/http.dart' as http;

class ItemHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/item';

  static Future<List<Item>> fetchAll() async {
    var url = await http.get(Uri.parse('${apiUrl}/fall'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    print(list);
    return list;
  }

  static Future<List<Item>> fetch5Items() async {
    var url = await http.get(Uri.parse('${apiUrl}/findItems?sortBy=oldest&start=0&count=5'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    print(list);
    return list;
  }
}