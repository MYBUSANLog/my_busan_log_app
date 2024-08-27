import 'dart:convert';

import '../vo/item.dart';
import 'package:http/http.dart' as http;

class ItemHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/item';

  static Future<List<Item>> fetchAll() async {
    var url = await http.get(Uri.parse('${apiUrl}/all'));
    var mapList = jsonDecode(url.body);

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    return list;
  }
}