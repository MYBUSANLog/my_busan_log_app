import 'dart:convert';

import 'package:busan_trip/vo/store.dart';
import 'package:http/http.dart' as http;

class StoreHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/store';

  static Future<Store?> fetchStoreById(int s_idx) async {
    print('121212312132132165456465456456456456465465465');
    final response = await http.get(Uri.parse('${apiUrl}/findByIdx?s_idx=${s_idx}'));
    print('121212312132132165456465456456456456465465465');
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return Store.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load store data');
    }
  }

  static Future<List<Store>> fetch5Stores() async {
    var url = await http.get(Uri.parse('${apiUrl}/all?sortBy=latest'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Store> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Store store = Store.fromJson(map);
      list.add(store);
    }

    print(list);
    return list;
  }
}