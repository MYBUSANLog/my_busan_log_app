import 'dart:convert';

import 'package:http/http.dart' as http;

import '../vo/res_item.dart';

class ResItemHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/res';

  static Future<List<ResItem>> fetchAllRestaurants(int start, int count) async {
    var url = await http.get(Uri.parse('${apiUrl}/findpage?start=$start&count=$count'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<ResItem> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      ResItem resItem = ResItem.fromJson(map);
      list.add(resItem);
    }

    print(list);
    return list;
  }

  // API에서 데이터를 가져와 Restaurant 리스트로 변환
  static Future<List<ResItem>> fetchAll() async {
    var url = await http.get(Uri.parse('${apiUrl}/all'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes)) as List;

    List<ResItem> list = [];

    for (var map in mapList) {
      ResItem restaurant = ResItem.fromJson(map);
      list.add(restaurant);
    }

    print(list);
    return list;
  }
}